From: Gabriel C <nix.or.die@googlemail.com>
Subject: Re: acpi=off vs. blacklist
Date: Tue, 31 Jul 2007 12:36:47 +0200
Message-ID: <46AF10BF.2090303@googlemail.com>
References: <200707311235.53302.philipp.marek@bmlv.gv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:2507 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755044AbXGaKld (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Jul 2007 06:41:33 -0400
Received: by nf-out-0910.google.com with SMTP id g13so212257nfb
        for <linux-acpi@vger.kernel.org>; Tue, 31 Jul 2007 03:41:32 -0700 (PDT)
In-Reply-To: <200707311235.53302.philipp.marek@bmlv.gv.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Ph. Marek" <philipp.marek@bmlv.gv.at>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Ph. Marek wrote:
[ added linux-acpi to CC ]
> Hello everybody!
> 
> I have two machines which freeze during boot; this seems to be ACPI-related, 
> because with acpi=off they start.
> 
> The first one is the HP DC 7700; some summary can be seen on
>   http://forums1.itrc.hp.com/service/forums/questionanswer.do?threadId=1081719
> It hangs after a line
>   ACPI assume root bridge[\sp_.pci0] bus is 0
> 
> The second one is a notebook; a Roda Rocky III+ RK886EX, which just shows a 
> blank screen.
> 
> As we drive many machines from the same kernel image via PXE, I tried to 
> insert them into drivers/acpi/blacklist.c; but that doesn't help, either - 
> the notebook hangs as before, no matter whether I set is_critical_error or 
> not. 
>  [ I suppose I wrote the entries wrong; is there some HOWTO? I used
>    acpidump/acpixtract/acpitbl, copied other blacklist entries, and took
>    "OEM Table ID", "OEMID", "OEM REVISION". Help? ]
> 
> 
> Using the "ACPI debug" kernel option showed no more messages.
> 
> 
> Help, please? What can/should I do now?
> 
> 
> Regards,
> 
> Phil
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
