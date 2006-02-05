From: Arthur Huillet <arthur.huillet@agoctrl.org>
Subject: Re: Question about AthlonXP on nforce 2 : C2-C3 states
Date: Sun, 5 Feb 2006 16:07:50 +0100
Message-ID: <20060205160750.4a1c1b3e.arthur.huillet@agoctrl.org>
References: <20060205152120.1688bd7b.arthur.huillet@agoctrl.org>
	<20060205143742.GA20815@tangens.sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ABesancon-103-1-6-191.w193-252.abo.wanadoo.fr ([193.252.219.191]:60638
	"EHLO Chani.agoctrl.org") by vger.kernel.org with ESMTP
	id S1750911AbWBEPHu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 5 Feb 2006 10:07:50 -0500
In-Reply-To: <20060205143742.GA20815@tangens.sinus.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Troller <patrol@sinus.cz>
Cc: linux-acpi@vger.kernel.org

Hi,

On Sun, 5 Feb 2006 15:37:42 +0100
Pavel Troller <patrol@sinus.cz> wrote:

> If you will see more than 100 in the first line and more than 1000 in the second one, your
> Cx states are blocked by BIOS.

I'm getting 101 and 1001 indeed : 
P_LVL2_LAT:       101
P_LVL3_LAT:       1001

Is there no way to tell my BIOS to unblock those states ? I mean, are they blocked for stability
purposes (in what case I assume this is a workaround for a bug in the chipset/CPU/whatever), or are
they just not enabled for an obscure reason ?

Thanks.
 -- 
Greetings, 
A.H.
