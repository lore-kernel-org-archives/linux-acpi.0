From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: eeepc-laptop: bugreport
Date: Thu, 26 Nov 2009 16:48:56 +0000
Message-ID: <20091126164856.GA19208@srcf.ucam.org>
References: <cone.1258203372.445001.1633.1000@eeekiste> <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com> <cone.1258211472.464906.1633.1000@eeekiste> <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com> <cone.1258312767.545625.1812.1000@eeekiste> <71cd59b00911260703r284b5bfdn3144de4db74b7c3a@mail.gmail.com> <cone.1259253925.112628.13921.1000@eeekiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:53075 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760152AbZKZQtA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Nov 2009 11:49:00 -0500
Content-Disposition: inline
In-Reply-To: <cone.1259253925.112628.13921.1000@eeekiste>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andrej.gelenberg@udo.edu
Cc: Corentin Chary <corentin.chary@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

On Thu, Nov 26, 2009 at 05:45:25PM +0100, andrej.gelenberg@udo.edu wrote:

> I think it is better not to let switch the rfkill
> on button in the driver itself.

It doesn't. Disable rfkill-input if you don't want this behaviour.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
