From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: regression from 2.6.23-rc2 to -rc3 BAT missing
Date: Mon, 13 Aug 2007 14:07:14 +0400
Message-ID: <46C02D52.40002@gmail.com>
References: <20070813094354.GA4881@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:41750 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762795AbXHMKHy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Aug 2007 06:07:54 -0400
Received: by ug-out-1314.google.com with SMTP id j3so560277ugf
        for <linux-acpi@vger.kernel.org>; Mon, 13 Aug 2007 03:07:19 -0700 (PDT)
In-Reply-To: <20070813094354.GA4881@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Norbert,

Do you know if you have SBS or CM battery? 
What driver do you use: sbs.ko or battery.ko?

Regards,
Alex.



Norbert Preining wrote:
> Hi all!
> 
> Starting with 2.6.23-rc3 the battery from my laptop (Acer TM3012) is
> missing for linux (but not physically):
> 
> ACPI: AC Adapter [ACAD] (on-line)
> ACPI: Battery Slot [BAT1] (battery absent)
> 
> But it is definitely there and running, even when I unplug the AC power.
> 
> Any patch I can use to change this?
> 
> Best wishes
> 
> Norbert
> 
> -------------------------------------------------------------------------------
> Dr. Norbert Preining <preining@logic.at>        Vienna University of Technology
> Debian Developer <preining@debian.org>                         Debian TeX Group
> gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
> -------------------------------------------------------------------------------
> GLOSSOP (n.)
> A rouge blob of food. Glossops, which are generally streaming hot and
> highly adhesive invariably fall off your spoon and on to the surface
> of your host's highly polished antique-rosewood dining table. If this
> has not, or may not have, been noticed by the company present, swanage
> (q.v.) may be employed.
> 			--- Douglas Adams, The Meaning of Liff
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

