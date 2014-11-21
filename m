From: "Dean A." <linux-dev@sensoray.com>
Subject: Hardware error from APEI =?UTF-8?Q?question=3F?=
Date: Fri, 21 Nov 2014 13:51:29 -0600
Message-ID: <b8cf6dca143125ddebd0e4700aac8f13@sensoray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

We're receiving hardware kernel panics on kernel 3.13.  Has anyone seen 
similar hardware errors on the Intel Ivytown/C600 architecture from 
their PCI/PCIe cards?  These errors do not occur with the same card on 
other PCI chipsets (eg. 82G33/P35/P31, ICH9 family, 82801 PCI bridge).


{1} {Hardware Error}: Hardware error from APEI Generic Hardware Error 
Source: 32993
{1} {Hardware Error}: event severity: fatal
{1} {Hardware Error}:  Error 0, type: fatal
{1} {Hardware Error}:   section_type: PCIe error
{1} {Hardware Error}:   port_type: 1, legacy PCI end point
{1} {Hardware Error}:   version: 1.0
{1} {Hardware Error}:   command: 0x0007, status: 0x0018
{1} {Hardware Error}:   device_id: 0000:06:00.0
{1} {Hardware Error}:   slot: 7
{1} {Hardware Error}:   secondary_bus: 0x00
{1} {Hardware Error}:   vendor_id: 0x1797, device_id: 0x6869
{1} {Hardware Error}:   class_code: 000000
Kernel panic - not syncing: Fatal hardware error!
Shutting down cpus with NMI
Rebooting in 30 seconds
