From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH] acpi: Avoid dropping rapid hotkey events (or other	GPEs)
 on Asus EeePC
Date: Thu, 17 Jul 2008 16:30:37 +0400
Message-ID: <487F3B6D.3090507@suse.de>
References: <487D23C3.5070301@student.cs.york.ac.uk> <487F31D7.30803@suse.de> <20080717121309.GF31732@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759316AbYGQMbX@vger.kernel.org>
In-Reply-To: <20080717121309.GF31732@khazad-dum.debian.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: alan-jenkins@tuffmail.co.uk, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Henrique de Moraes Holschuh wrote:
> On Thu, 17 Jul 2008, Alexey Starikovskiy wrote:
>> Thanks for the patch, ACK.
> 
> This one fixes a potentially bad problem, since we could ignore more than
> just hot key EC events by accident.  Maybe it should go to -stable?

I vote for it

Regards,
Alex.
