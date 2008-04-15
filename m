From: Ron Rechenmacher <ron@fnal.gov>
Subject: Re: suspend/resume memory corruption on Dell Latitude D830
Date: Mon, 14 Apr 2008 22:53:00 -0500
Message-ID: <4804269C.4050507@fnal.gov>
References: <4803DD86.9060105@fnal.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailgw2.fnal.gov ([131.225.111.12]:62627 "EHLO mailgw2.fnal.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762780AbYDOD4L (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Apr 2008 23:56:11 -0400
Received: from mailav2.fnal.gov (mailav2.fnal.gov [131.225.111.20])
 by mailgw2.fnal.gov
 (iPlanet Messaging Server 5.2 HotFix 2.06 (built Mar 28 2005))
 with SMTP id <0JZC00GB7LEZGS@mailgw2.fnal.gov> for linux-acpi@vger.kernel.org;
 Mon, 14 Apr 2008 22:53:01 -0500 (CDT)
Received: from mailgw2.fnal.gov ([131.225.111.12])
 by mailav2.fnal.gov (SAVSMTP 3.1.7.47) with SMTP id M2008041422530108798 for
 <linux-acpi@vger.kernel.org>; Mon, 14 Apr 2008 22:53:01 -0500
Received: from conversion-daemon.mailgw2.fnal.gov by mailgw2.fnal.gov
 (iPlanet Messaging Server 5.2 HotFix 2.06 (built Mar 28 2005))
 id <0JZC00801L2GED@mailgw2.fnal.gov> (original mail from ron@fnal.gov)
 for linux-acpi@vger.kernel.org; Mon, 14 Apr 2008 22:53:01 -0500 (CDT)
Received: from [192.168.1.101]
 (adsl-75-56-59-98.dsl.emhril.sbcglobal.net [75.56.59.98])
 by mailgw2.fnal.gov (iPlanet Messaging Server 5.2 HotFix 2.06 (built Mar 28
 2005)) with ESMTPSA id <0JZC00F2ELGC5B@mailgw2.fnal.gov> for
 linux-acpi@vger.kernel.org; Mon, 14 Apr 2008 22:53:00 -0500 (CDT)
In-reply-to: <4803DD86.9060105@fnal.gov>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ron Rechenmacher <ron@fnal.gov>
Cc: linux-acpi@vger.kernel.org

More information on is at
     http://fnapcf.fnal.gov/~ron/dell_susp_3.5G_2blocks.txt
and http://fnapcf.fnal.gov/~ron/dell_susp_3.5G_2blocks.dmesg.txt

Is there a way to determine which acpi mapping/allocation is not being 
honored or is missing and/or using some memmap= kernel param
to get the kernel to stay away from the memory being changed during 
suspend/resume? (any other kernel param that might be useful?)

Thanks,
Ron
