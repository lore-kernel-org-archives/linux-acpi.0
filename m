From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC 1/1] ACPI: pci_irq, add PRT_ quirk for IBM Bartolo
Date: Tue, 12 Apr 2011 16:59:21 +0100
Message-ID: <20110412155921.GA531@srcf.ucam.org>
References: <4C87A62E.30108@gmail.com>
 <1302598086-3622-1-git-send-email-jslaby@suse.cz>
 <20110412085622.43488ed9@jbarnes-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110412085622.43488ed9@jbarnes-desktop>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Jiri Slaby <jslaby@suse.cz>, jirislaby@gmail.com, Robert Hancock <hancockrwd@gmail.com>, lenb@kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 12, 2011 at 08:56:22AM -0700, Jesse Barnes wrote:

> I'll defer to the ACPI experts, Len or Matthew have you checked this
> one out?

Windows appears to work without this, so it seems likely that we're 
doing something wrong in some other sense, but I don't think we have a 
good idea as to what we're doing wrong...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
