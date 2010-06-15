From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: "ignoring host bridge windows from ACPI" in a recent laptop
Date: Tue, 15 Jun 2010 08:47:44 -0600
Message-ID: <201006150847.44777.bjorn.helgaas@hp.com>
References: <1276600703.31461.53.camel@thorin> <201006150727.10978.bjorn.helgaas@hp.com> <1276609513.31461.78.camel@thorin>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1276609513.31461.78.camel@thorin>
Sender: linux-kernel-owner@vger.kernel.org
To: Bernd Petrovitsch <bernd@sysprog.at>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, June 15, 2010 07:45:13 am Bernd Petrovitsch wrote:
> The not really correctly working device (so far) is the graphics card
> ---- snip  ----
> 01:00.0 VGA compatible controller: nVidia Corporation GT216 [GeForce GT 330M] (rev a2)
> ---- snip  ---- 
> as I get only some standard VESA resolution (800x600 or so - but there
> is a full-hd-screen on it) with X.
> I'm in the process of playing around with that ("nv vs nouveau driver"
> or "is it a system-config-display issue") and writing something in the
> Fedora-12 bugzilla eventually - if only to see where the real problem
> lies.

If the behavior changes with "pci=use_crs", let me know because I
should look into that more.  If "pci=use_crs" doesn't make any
difference with this issue, then it's probably a config or driver
issue that's beyond my knowledge.

Bjorn
