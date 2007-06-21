From: Luca <kronos.it@gmail.com>
Subject: Re: [lm-sensors] [RFC] ACPI based hwmon driver for ASUS
Date: Thu, 21 Jun 2007 22:11:24 +0200
Message-ID: <68676e00706211311v3776aff2tff3b12074935742@mail.gmail.com>
References: <20070513223329.GA29207@dreamland.darkstar.lan>
	 <46520F36.4080006@assembler.cz>
	 <68676e00705211453n69de6868lc5da2cad64f65699@mail.gmail.com>
	 <46528B6F.3050701@assembler.cz>
	 <20070602222829.GA11893@dreamland.darkstar.lan>
	 <467ACB2A.4070707@assembler.cz> <467ACE57.2010400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.226]:49202 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755069AbXFUULZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jun 2007 16:11:25 -0400
Received: by nz-out-0506.google.com with SMTP id n1so721065nzf
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jun 2007 13:11:24 -0700 (PDT)
In-Reply-To: <467ACE57.2010400@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Rudolf Marek <r.marek@assembler.cz>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 6/21/07, Alexey Starikovskiy <aystarik@gmail.com> wrote:
> Hi,
>
> I think you might be interested in following patch, which implements _ACPI_ driver for the same hardware...
> It is only "proof of concept" at the moment, but it does main thing -- reads hwmon device using ACPI interfaces.

Well, reading is easy and is already implemented in the driver that I
posted. The problem is to figure out how to control the various stuff
(fans, and maybe some of the other ASUS features).

Luca
