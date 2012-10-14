From: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Subject: Re: [PATCH V3 0/3] PNP: Allow PNP resources to be disabled (interface)
Date: Sun, 14 Oct 2012 17:57:12 +0200
Message-ID: <507AE0D8.6090909@gmx.net>
References: <50158321.4030007@gmx.net> <201208022340.16948.rjw@sisk.pl> <5055DFB6.6070809@gmx.net> <201209182342.30244.rjw@sisk.pl> <506C6065.3070202@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:58038 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754022Ab2JNP5U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Oct 2012 11:57:20 -0400
In-Reply-To: <506C6065.3070202@gmx.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: bhelgaas@google.com, lenb@kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On 03/10/12 17:57, Witold Szczeponik wrote:

[...]

> 
> Len and Bjorn, 
> 
> any chances to include the patches in 3.7?  I checked them 
> against 3.6 and they applied without any change.  Or should 
> I resend them individually? 
> 
> Thanks. 
> 
> --- Witold
> 

Hi Len, hello Bjorn, 

the patches submitted in https://lkml.org/lkml/2012/7/29/85 have
not been objected by anyone, make the code simpler, and fix a 
current problem when using the "/sys/bus/pnp/devices/*/resources" 
interface.  I have been running them since at least Linux 3.0, 
with adapted changes in previous versions.  I have not seen any
regressions and I do not expect any regressions from these
patches. 

Bjorn had reviewed them and I am wondering what I can do to have 
them included in (one of) the next Linux kernel(s).

If there is any information that you need before an inclusion is
possible, just let me know. 

--- Witold
