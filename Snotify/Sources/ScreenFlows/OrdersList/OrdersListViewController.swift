//Copyright © 2019 Snotify. All rights reserved.

import Cocoa

private enum CellIdentifiers: String {
    case name = "CustomerNameCell"
    case amount = "AmountCell"
}

private enum ColumnIndex: Int {
    case name = 0
    case amount
}

class OrdersListViewController: NSViewController {
    @IBOutlet private weak var tableView: NSTableView!
    @IBOutlet private weak var apiKeyField: NSTextField!
    @IBOutlet private weak var passwordField: NSSecureTextField!
    @IBOutlet private weak var storeNameField: NSTextField!
    @IBOutlet private weak var actionButton: NSButton!
    @IBOutlet private weak var progressIndicator: NSProgressIndicator!
    @IBOutlet private weak var emptyStateLabel: NSTextField!
    @IBOutlet private weak var errorLabel: NSTextField!
    
    private let ordersListModel: OrdersListModel = OrdersListModel()

    @IBAction private func fetchOrdersAction(_ sender: NSButton) {
        let apiKey = apiKeyField.stringValue
        let password = passwordField.stringValue
        let storeName = storeNameField.stringValue
        let shop = Shop(uniqueName: storeName, apiKey: apiKey, password: password)
        SelectedShop.shop = shop
        fetchOrders()
    }

    private func fetchOrders() {
        errorLabel.isHidden = true
        emptyStateLabel.isHidden = true
        progressIndicator.startAnimation(nil)
        ordersListModel.orders(success: { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.setTableViewEmptyState()
                self?.progressIndicator.stopAnimation(nil)
            }
        }, failure: { [weak self] errorMessage in
            DispatchQueue.main.async {
                self?.setTableViewEmptyState()
                self?.progressIndicator.stopAnimation(nil)
                self?.show(error: errorMessage)
            }
        })
    }
    
    private func show(error: String) {
        errorLabel.isHidden = false
        errorLabel.stringValue = error
        errorLabel.textColor = .red
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setActionButton()
        configureEmptyStateLabel()
        configureProgressIndicator()
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        setTableViewEmptyState()
    }
    
    private func setTableViewEmptyState() {
        if tableView.numberOfRows == 0 {
            emptyStateLabel.isHidden = false
        } else {
            emptyStateLabel.isHidden = true
        }
    }

    private func setActionButton() {
        actionButton.title = "shopify.orders.get-orders-button.label".localized
    }
    
    private func configureProgressIndicator() {
        progressIndicator.appearance = NSAppearance(named: .aqua)
    }
    
    private func configureEmptyStateLabel() {
        emptyStateLabel.stringValue = "shopify.orders.no-order-label".localized
    }
}

extension OrdersListViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return ordersListModel.ordersList.count
    }
}

extension OrdersListViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var text: String = ""
        var cellIdentifier: String = ""
        
        if tableColumn == tableView.tableColumns[0] {
            text = ordersListModel.ordersList[row].customer?.fullName ?? "-"
            cellIdentifier = CellIdentifiers.name.rawValue
        } else if tableColumn == tableView.tableColumns[1] {
            let order = ordersListModel.ordersList[row]
            text = "\(order.currency) \(order.totalPrice)"
            cellIdentifier = CellIdentifiers.amount.rawValue
        }
        
        let itemIdentifier = NSUserInterfaceItemIdentifier(rawValue: cellIdentifier)
        if let cell = tableView.makeView(withIdentifier: itemIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        return nil
    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 25.0
    }
}
