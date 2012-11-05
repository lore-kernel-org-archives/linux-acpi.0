From: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: [PATCH v3] Enable A20 using KBC for some MSI laptops to fix S3 resume
Date: Mon, 5 Nov 2012 21:35:19 +0100
Message-ID: <201211052135.20009.linux@rainbow-software.org>
References: <201210261056.44225.zary@gsystems.sk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201210261056.44225.zary@gsystems.sk>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: hpa@zytor.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday 26 October 2012 10:56:44 Ondrej Zary wrote:
> Some MSI laptop BIOSes are broken - INT 15h code uses port 92h to enable
> A20 line but resume code assumes that KBC was used.
> The laptop will not resume from S3 otherwise but powers off after a while
> and then powers on again stuck with a blank screen.
>
> Fix it by enabling A20 using KBC. Affected laptop list and DMI data are
> from bug reports at Ubuntu Launchpad.
>
> Also add kernel parameter to easily activate this quirk on any system.
>
> Only compile tested. The original patch was tested with EX600 and PR200.
>
> Fixes https://bugzilla.kernel.org/show_bug.cgi?id=12878

The bug was marked as RESOLVED CODE_FIX but I wonder what happened to this 
patch. Was it applied? Or is someone working on a better way to fix this 
problem?

-- 
Ondrej Zary
