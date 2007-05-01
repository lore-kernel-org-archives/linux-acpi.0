From: Markus Feldmann <feldmann_markus@gmx.de>
Subject: Re: syntax error, unexpected PARSEOP_NAMESEG, expecting PARSEOP_DEFINITIONBLOCK
Date: Tue, 01 May 2007 12:38:51 +0200
Message-ID: <463718BB.6070804@gmx.de>
References: <46370B26.2080704@gmx.de> <8f8ff01d0705010308q197c7314o1f3dd34670b58c05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:58244 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1031144AbXEAKif (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 May 2007 06:38:35 -0400
In-Reply-To: <8f8ff01d0705010308q197c7314o1f3dd34670b58c05@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Alexey Starikovskiy schrieb:
> 1. why do you think that making custom DSDT is going to help you?
> 2. please attach your dsdt.dsl, so we could see on what iasl barks...
>  From your report it looks like you trying to fed it with some non-aml
> code.
> 
> Regards,
> Alex.
To 1.) I thought that my dsdt was changed, but that is my mistake. I 
compared my dsdt_2.6.18.dsl with my dsdt_2.6.21.dsl and they seems to be 
equal.
To 2.) I didnt know aml-code, but i followed the Instructions from 
http://acpi.sourceforge.net/ to fix my dsdt-table .

Because the original error Message, can you please tell me what i should 
do to correct this?

bye Markus

