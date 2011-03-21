From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Hot plug issue on 2.6.38
Date: Mon, 21 Mar 2011 22:34:08 +0000
Message-ID: <20110321223408.GA17412@srcf.ucam.org>
References: <201103052254.48515.rjw@sisk.pl> <201103170119.17647.rjw@sisk.pl> <AANLkTim39fjrAp4OW_MfpbZkz-YYW5E2NOHuo1j=svmW@mail.gmail.com> <201103172222.33336.rjw@sisk.pl> <20110317215609.GA5917@xanatos> <20110321222705.GA4139@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110321222705.GA4139@xanatos>
Sender: linux-kernel-owner@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Yinghai Lu <yinghai@kernel.org>, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Try setting CONFIG_HOTPLUG_PCI_ACPI to y as well, just to rule that out?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
