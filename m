From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: eeepc-laptop: bugreport
Date: Fri, 27 Nov 2009 11:27:53 +0000
Message-ID: <4B0FB7B9.9040902@tuffmail.co.uk>
References: <cone.1258203372.445001.1633.1000@eeekiste> <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com> <cone.1258211472.464906.1633.1000@eeekiste> <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com> <cone.1258312767.545625.1812.1000@eeekiste> <71cd59b00911260703r284b5bfdn3144de4db74b7c3a@mail.gmail.com> <cone.1259253925.112628.13921.1000@eeekiste> <20091126164856.GA19208@srcf.ucam.org> <cone.1259320879.557715.3035.1000@eeekiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:1723 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbZK0L1s (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Nov 2009 06:27:48 -0500
Received: by ey-out-2122.google.com with SMTP id 25so111896eya.5
        for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2009 03:27:54 -0800 (PST)
In-Reply-To: <cone.1259320879.557715.3035.1000@eeekiste>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andrej.gelenberg@udo.edu
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Corentin Chary <corentin.chary@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net

andrej.gelenberg@udo.edu wrote:
> Hi,
>
> how? It's not possible at the moment in eeepc-laptop.

CONFIG_RFKILL_INPUT=n. By default this is hidden; you have to enable 
CONFIG_EMBEDDED=y.

rfkill-input is alledgedly going to be removed soon, see 
Documentation/feature-removal-schedule.txt.
