From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] acpi ec_sys: Be more cautious about ec write access
Date: Sun, 1 Aug 2010 02:13:55 +0200
Message-ID: <201008010213.56501.trenn@suse.de>
References: <201007292216.13568.trenn@suse.de> <1280435424-19656-1-git-send-email-trenn@suse.de> <20100730163717.GB32120@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20100730163717.GB32120@khazad-dum.debian.net>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: mjg59@srcf.ucam.org, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, astarikovskiy@suse.de
List-Id: linux-acpi@vger.kernel.org

On Friday 30 July 2010 06:37:17 pm Henrique de Moraes Holschuh wrote:
> On Thu, 29 Jul 2010, Thomas Renninger wrote:
> > - Only allow root to read/write io file (sever bug!)
>
> I'd go further, and only allow CAP_SYS_RAWIO.
I'll have a look and eventually come up with something on-top.

> > +	  The kernel accesses the EC through ACPI parsed code provided by BIOS
> > +	  tables. This option allows to access the EC directly without ACPI
> > +	  code being involved.
>
> This is not really true.  Kernel drivers can, and do access the EC without
> help from the AML firmware (DSDT, SSDT...).
Yes, the native laptop driver hacks which should not exist...
Generally the EC should only be accessed via ACPI interpreted code, is it 
really worth to mention these exceptions at this point?

   Thomas
