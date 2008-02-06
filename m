From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH for review] ACPI: Create /sys/firmware/acpi/interrupts/ counters
Date: Tue, 5 Feb 2008 17:44:36 -0700
Message-ID: <200802051744.36371.bjorn.helgaas@hp.com>
References: <200802050230.10873.lenb@kernel.org> <20080205221805.GC6950@suse.de> <200802051812.09228.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763115AbYBFAnj@vger.kernel.org>
In-Reply-To: <200802051812.09228.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Greg KH <gregkh@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 05 February 2008 04:12:09 pm Len Brown wrote:
> is there
> a version of cat that prints the file name before
> the contents of each file?

I use "grep . *" for this sort of thing.
