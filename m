From: Stian Jordet <liste@jordet.net>
Subject: Display dimmed down after resume
Date: Mon, 22 May 2006 22:40:32 +0200
Message-ID: <1148330432.8028.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from buick.jordet.net ([217.8.143.72]:38075 "EHLO buick.jordet.net")
	by vger.kernel.org with ESMTP id S1751042AbWEVUki (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 May 2006 16:40:38 -0400
Received: from chevrolet.jordet ([192.168.1.2]:34762)
	by buick.jordet.net with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.62)
	(envelope-from <liste@jordet.net>)
	id 1FiHCb-0004XN-Gf
	for linux-acpi@vger.kernel.org; Mon, 22 May 2006 22:40:33 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I got myself a Fujitsu-Siemens Lifebook P7120 this weekend. Fantastic
laptop. And with Ubuntu Dapper, (almost) everything works. I have yet to
make suspend work on a self compiled kernel, but Ubuntu almost manages
it. 

My problem is that after resume, the screen is totally dimmed down. I
have to use Fn+F7 to get light again.Anyone have an explanation for
this? Or even better, a solution :D Else, echo 3
> /proc/acpi/video/GFX0/LCD/brightness gives: "echo: write error:
Invalid argument". Guess it's unsupported on this machine?

Hope this is the right list for this.

Best regards,
Stian

