From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: kacpid consumes 100% cpu
Date: Sun, 21 Oct 2007 21:42:59 +0400
Message-ID: <471B8FA3.5080200@gmail.com>
References: <f46c52560710200941x77f4bf95h1f0a4a770d780acb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:23153 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbXJURnN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Oct 2007 13:43:13 -0400
Received: by ug-out-1314.google.com with SMTP id z38so810413ugc
        for <linux-acpi@vger.kernel.org>; Sun, 21 Oct 2007 10:43:11 -0700 (PDT)
In-Reply-To: <f46c52560710200941x77f4bf95h1f0a4a770d780acb@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rustom Mody <rustompmody@gmail.com>
Cc: linux-acpi@vger.kernel.org

Rustom Mody wrote:
> I had an old P4 (1.2 GHz) box that was running debian etch fine.
> Recently upgraded the motherboard to a duo core on a 945G chipset board.
> 
> Now if I start windows-XP and put it in standby mode and then restart
> linux, linux becomes unusable with kacpid taking 100% cpu.  Starting
> linux with kernel option acpi=off works and sometimes if it is
> restarted without the option it keeps working and sometimes not.
acpidump output might give some hints. Please open bug at bugzilla.kernel.org against ACPI
and put all the information there.
> 
> Evidently windows standby leaves some state in the BIOS that linux
> cant clean up/detect.  What??
Could you try to use "magic SysRq + t" to see what threads are doing?
> 
> The output of uname -vr is as follows:
> 2.6.22-2-686 #1 SMP Fri Aug 31 00:24:01 UTC 2007
> 
> Thanks
> 
> Rustom  Mody
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

