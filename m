From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Problem with recognizing lid state from 3.13.7 on i686
Date: Wed, 02 Apr 2014 21:23:31 +0200
Message-ID: <2222641.cumF3Fyysl@vostro.rjw.lan>
References: <CAN4dU3FyAO84RxttvTsmveOvxACXXf6=TP1ovEdT6dPd7KGQ8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63996 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1030216AbaDBTHm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Apr 2014 15:07:42 -0400
In-Reply-To: <CAN4dU3FyAO84RxttvTsmveOvxACXXf6=TP1ovEdT6dPd7KGQ8w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tobias Caspers <tcugma@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wednesday, April 02, 2014 05:50:34 PM Tobias Caspers wrote:
> 
> --001a11c1d718bd39e404f6113eef
> Content-Type: text/plain; charset=ISO-8859-1
> 
> Dear kernel developer,
> 
> there seems to be a problem with recognizing lid state on some i686
> hardware from kernel 3.13.7 on.
> For me with a Samsung N150 and arch linux it is as follows:
> 
> Monitoring lid by systemd: after first lid close, a endless chain of
> suspends follows
> Monitoring lid by XFCE: toggling suspend by lid close works sometimes.
> 
> For some more details see https://bbs.archlinux.org/viewtopic.php?id=179216

Care to file a bug report for this problem at bugzilla.kernel.org against ACPI?

Rafael

