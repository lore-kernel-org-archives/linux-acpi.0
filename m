From: Bernhard Thaler <bernhard.thaler@wvnet.at>
Subject: Re: [Bugfix v2] x86/PCI/ACPI: Fix regression caused by commit 63f1789ec716
Date: Sun, 29 Mar 2015 23:11:37 +0200
Message-ID: <55186A89.8090204@wvnet.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Received: from 178.115.129.124.wireless.dyn.drei.com (HELO [172.16.0.2]) (bernhard.thaler@wvnet.at@[178.115.129.124])
           (SMTPAUTH User bernhard.thaler@wvnet.at)
          (envelope-sender <bernhard.thaler@wvnet.at>)
          by smtp.wvnet.at (qmail-ldap-1.03) with SMTP
          for <linux-acpi@vger.kernel.org>; 29 Mar 2015 21:11:45 -0000
In-Reply-To: 1427267843-18710-1-git-send-email-jiang.liu@linux.intel.com
Sender: linux-pci-owner@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Len Brown <lenb@kernel.org>
Cc: Lv Zheng <lv.zheng@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

I tested this patch applied to 4.0-rc5. APU.1C network interfaces are
working correctly again.
