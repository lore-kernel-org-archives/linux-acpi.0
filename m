From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: 2.6.18-rc5-mm1
Date: Sun, 03 Sep 2006 18:00:32 -0700
Message-ID: <44FB7AB0.10103@goop.org>
References: <EB12A50964762B4D8111D55B764A84548839C0@scsmsx413.amr.corp.intel.com> <20060903175048.6fed40ab.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:52121 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932186AbWIDBAb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Sep 2006 21:00:31 -0400
In-Reply-To: <20060903175048.6fed40ab.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Matthias Hentges <oe@hentges.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Andrew Morton wrote:
> Spose so.
>
> But what _did_ cause it?  Looks like we took an IRQ and then leapt into
> outer space, when do_IRQ() called desc->handle_irq().
>   

It was specifically an MSI interrupt problem; disabling CONFIG_MSI fixed 
the problem for me.  GregKH said that the MSI patch series in rc5-mm1 is 
broken, and had been replaced.

    J

-- 
VGER BF report: H 0
