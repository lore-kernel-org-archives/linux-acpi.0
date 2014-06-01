From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: ACPI: Improve behaviour on Apple hardware
Date: Sun,  1 Jun 2014 12:33:52 -0400
Message-ID: <1401640436-1947-1-git-send-email-matthew.garrett@nebula.com>
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com
List-Id: linux-acpi@vger.kernel.org

Apple hardware behaves differently depending on whether or not the OS claims
to be Darwin. Failing to report Darwin results in some hardware being
disabled. However, claiming to be Darwin also alters the behaviour of
battery reporting and PCI handling. These patches add support for reporting
Darwin support and fixing up the behavioural quirks that are exposed as a
result.

-- 
Matthew Garrett | matthew.garrett@nebula.com
