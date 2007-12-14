From: ice` <icestorm@ngi.it>
Subject: Re: Help please
Date: Fri, 14 Dec 2007 16:22:29 +0100
Message-ID: <47629FB5.7050009@ngi.it>
References: <47629334.50201@thecybersource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out28.alice.it ([85.33.2.28]:2860 "EHLO
	smtp-out28.alice.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbXLNPj1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Dec 2007 10:39:27 -0500
In-Reply-To: <47629334.50201@thecybersource.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Cyber Source ha scritto:
> Hello,
>  To simplify my question, I'm going to include an excerpt from a post 
> to our lug here. Would you possible have a work around for this 
> problem? TIA
Hi,
sorry if I follow your post but I have a problem with ACPI and I think 
that the culprit is always Phoenix Bios as in your case (I have an HP 
dv2500 laptop with bios F.21)...
I've read that Phoenix Bios has been planned to allow only Microsoft 
systems (in particular Vista) to read ACPI data and therefore manage CPU.
Someone can confirm this?
I can't manage cpu frequency scaling which, by the way, is supported by 
my cpu (C2D T7500) and in fact inside Vista works pretty well.
This is the ACPI error I get when I modprobe acpi-cpufreq:

[ 1008.017253] ACPI Error (psargs-0355): [\_PR_.CPU0._PSS] Namespace 
lookup failure, AE_NOT_FOUND
[ 1008.017259] ACPI Error (psparse-0551): Method parse/execution failed 
[\_PR_.CPU1._PSS] (Node ffff81007cf59de0), AE_NOT_FOUND
[ 1008.017293] ACPI Exception (processor_perflib-0234): AE_NOT_FOUND, 
Evaluating _PSS [20070126]

I hope someone can clarify on this.

