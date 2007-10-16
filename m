From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: halt does not shut the system down
Date: Tue, 16 Oct 2007 21:06:09 +0400
Message-ID: <4714EF81.2070405@gmail.com>
References: <470A58AF.9080402@free.fr> <470C9731.6030200@free.fr> <470F4535.3050004@free.fr> <470F4F58.4080900@gmail.com> <470F7264.8070205@free.fr> <471342C8.2030305@free.fr> <4714979C.5010103@free.fr> <Pine.LNX.4.61.0710160835160.11232@chaos.analogic.com> <4714B7D7.7090005@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:52637 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759120AbXJPRGR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Oct 2007 13:06:17 -0400
Received: by ug-out-1314.google.com with SMTP id z38so120287ugc
        for <linux-acpi@vger.kernel.org>; Tue, 16 Oct 2007 10:06:16 -0700 (PDT)
In-Reply-To: <4714B7D7.7090005@free.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Cc: Dick Johnson <linux-os@analogic.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, robert.moore@intel.com, len.brown@intel.com

John Sigler wrote:

>          +===================================+
>          | Soft-Off by PWR-BTTN              |
>          |-----------------------------------|
>          | Instant-Off  ..... [v]            |
>          | Delay 4 Sec. ..... [ ]            |
>          |                                   |
>          |-----------------------------------|
>          |  ^V:Move ENTER:Accept ESC:Abort   |
>          +===================================+
> 
> 'Instant-Off' is the appropriate setting, right?
Actually, default should be 4 sec delay. OS should have 
a chance to shut down the system...

