From: andrej.gelenberg@udo.edu
Subject: Re: eeepc-laptop: bugreport
Date: Sun, 15 Nov 2009 18:32:46 +0100
Message-ID: <cone.1258306366.446137.1656.1000@eeekiste>
References: <cone.1258203372.445001.1633.1000@eeekiste> <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com> <cone.1258211472.464906.1633.1000@eeekiste> <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com> <cone.1258285991.924736.2588.1000@eeekiste> <4AFFF61E.6090707@tuffmail.co.uk> <cone.1258301205.852230.1663.1000@eeekiste> <4B002951.4080704@tuffmail.co.uk> <cone.1258304218.643429.1671.1000@eeekiste> <4B00354A.7000300@tuffmail.co.uk> <71cd59b00911150917k7d677fd0g509ab4edc1786fb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.HRZ.Uni-Dortmund.DE ([129.217.128.51]:61204 "EHLO
	postserver.uni-dortmund.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753238AbZKORco (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Nov 2009 12:32:44 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux acpi <linux-acpi@vger.kernel.org>

Hi,

Corentin Chary writes:

> Could you try to boot with acpi_osi="Linux" ?
> This might be fixed by
> http://git.iksaif.net/?p=acpi4asus.git;a=commitdiff;h=a57818b9177b521d418e25bf549a609d0e79cd4a;hp=cbf69cbf597b31201038ecd7630c90183543c488

this patch solved the problem.

Regards,
Andrej
