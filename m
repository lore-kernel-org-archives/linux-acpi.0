From: andrej.gelenberg@udo.edu
Subject: Re: eeepc-laptop: bugreport
Date: Fri, 27 Nov 2009 13:27:37 +0100
Message-ID: <cone.1259324857.296100.3035.1000@eeekiste>
References: <cone.1258203372.445001.1633.1000@eeekiste> <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com> <cone.1258211472.464906.1633.1000@eeekiste> <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com> <cone.1258312767.545625.1812.1000@eeekiste> <71cd59b00911260703r284b5bfdn3144de4db74b7c3a@mail.gmail.com> <cone.1259253925.112628.13921.1000@eeekiste> <20091126164856.GA19208@srcf.ucam.org> <cone.1259320879.557715.3035.1000@eeekiste> <4B0FB7B9.9040902@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.HRZ.Uni-Dortmund.DE ([129.217.128.51]:41492 "EHLO
	postserver.uni-dortmund.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751717AbZK0M2B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Nov 2009 07:28:01 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Corentin Chary <corentin.chary@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net

Hi,

the problem is, when i press wlan-key, the hotplug-work is triggerd,
but you can not say, which device to unplug.

My idea is to separate the key-event and rfkill-handler.
So you can bind key to userspace-tool, which turn the
rfkill on and off.

Besides i think the hotplug-workaround ist not very
good solution. If rfkill don't work propper
on other models, then isn't it better to use
software-rfkill from wlan-driver?
(to use staging drivers isn't good,
and good drivers have it implemented)

The hotplug-workaround can be maded by
userspace too (fake hotplug driver).
The benifit is, you can say, which device
should i unplug (and not hope,
that it is on slot 0).

Regards,
Andrej

Alan Jenkins writes:

> andrej.gelenberg@udo.edu wrote:
>> Hi,
>>
>> how? It's not possible at the moment in eeepc-laptop.
> 
> CONFIG_RFKILL_INPUT=n. By default this is hidden; you have to enable 
> CONFIG_EMBEDDED=y.
> 
> rfkill-input is alledgedly going to be removed soon, see 
> Documentation/feature-removal-schedule.txt.
