From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/2] drivers/misc/Makefile, Kconfig: cleanup
Date: Mon, 1 Dec 2008 08:41:48 +0100
Message-ID: <20081201074148.GA22463@uranus.ravnborg.org>
References: <4930307C.30106@oracle.com> <20081129083550.3c23af37.sfr@canb.auug.org.au> <alpine.LFD.2.00.0811281649001.24773@localhost.localdomain> <alpine.LFD.2.00.0811281702570.24773@localhost.localdomain> <alpine.LFD.2.00.0811281706540.24773@localhost.localdomain> <20081128223533.GA5175@uranus.ravnborg.org> <alpine.LFD.2.00.0811281801520.24773@localhost.localdomain> <20081129073816.GB8351@uranus.ravnborg.org> <alpine.LFD.2.00.0812010053100.3314@localhost.localdomain> <alpine.LFD.2.00.0812010102340.3314@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0812010102340.3314@localhost.localdomain>
Sender: linux-next-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Len Brown <len.brown@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>, x86@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Len.

> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 817f7f5..bcde73b 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -1,9 +1,6 @@
>  #
>  # Makefile for misc devices that really don't fit anywhere else.
>  #
> -obj- := misc.o	# Dummy rule to force built-in.o to be made
> -
> -obj-$(CONFIG_IBM_ASM)		+= ibmasm/
 ^^
Was this on purpose?
I do not think so...

	Sam
