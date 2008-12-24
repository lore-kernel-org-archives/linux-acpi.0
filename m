From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC PATCH 2/3] PCI: parallel resume for pci devices
 on bus 0
Date: Tue, 23 Dec 2008 21:47:33 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0812232146040.8076-100000@netrider.rowland.org>
References: <1230086170.562.210.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1230086170.562.210.camel@rzhang-dt>
Sender: linux-pci-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Barnes, Jesse" <jesse.barnes@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, 24 Dec 2008, Zhang Rui wrote:

> Then I have a question, what if the uchi_hcd is not loaded?
> the ehci host controller doesn't work in this case?

It does work.  But it handles only high-speed devices; low-speed and 
full-speed devices will be ignored (unless they are connected through 
a high-speed hub).

Alan Stern
