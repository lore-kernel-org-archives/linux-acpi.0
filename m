From: Fabio Comolli <fabio.comolli@gmail.com>
Subject: Re: [PATCH 0/8] device async action mechanism
Date: Thu, 16 Jul 2009 16:36:17 +0200
Message-ID: <b637ec0b0907160736r3477301fn25c495b03a18dc4a@mail.gmail.com>
References: <1247643512.26272.74.camel@rzhang-dt>
	 <87ocrm6xeq.fsf@basil.nowhere.org>
	 <1247710483.26272.170.camel@rzhang-dt>
	 <20090716114020.GA11928@khazad-dum.debian.net>
	 <4A5F2EEC.8010508@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f228.google.com ([209.85.218.228]:37110 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932257AbZGPOgS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jul 2009 10:36:18 -0400
In-Reply-To: <4A5F2EEC.8010508@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Zhang Rui <rui.zhang@intel.com>, Andi Kleen <andi@firstfloor.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Thu, Jul 16, 2009 at 3:45 PM, Arjan van de Ven<arjan@linux.intel.com=
> wrote:
> Henrique de Moraes Holschuh wrote:
>>
>> On Thu, 16 Jul 2009, Zhang Rui wrote:
>>>
>>> the kernel device suspend time is reduced from 3.2s to 2.8s after
>>> applying this patch set in my test box.
>>
>> It will give even a bigger boot time saving on ThinkPads, where ther=
e is a
>> Synaptics (or ALPS if you are unlucky) touchpad with the trackpoint =
behind
>> it... it takes about 2s to init both devices here. =C2=A0That's two =
seconds of
>> boot time you can shove off if it is being initialized assyncronousl=
y :-)
>>
>
> that's a different problem that I don't think this will solve; as lon=
g
> as you keep the boot of the kernel wait for all async actions, you're=
 going
> to hit that wait. In Moblin we have a (bad) patch to not do the wait,
> at some point we need to figure how to get a mainline-able patch....
> --

Is it possible for you to post that patch (or point to a website hostin=
g it)?



> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
