From: Adam M Belay <abelay@MIT.EDU>
Subject: Re: [PATCH] pnp: replace deprecated __check_region to
	request_region
Date: Thu, 11 Aug 2011 23:27:35 -0400
Message-ID: <20110811232735.u5qoybpr4gg8kckw@webmail.mit.edu>
References: <1312817901-5313-1-git-send-email-wangshaoyan.pt@taobao.com>
	<CAErSpo6Fh+zTMiSG+mjkNuA03cCEK7bej9y2oX+HfsScSYGFsw@mail.gmail.com>
	<CANxBZFrzmTDaUrmkGhKAVsZpXScEDxdJeBzcMbBjEW=6ozppGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:58048 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752541Ab1HLD1q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Aug 2011 23:27:46 -0400
In-Reply-To: <CANxBZFrzmTDaUrmkGhKAVsZpXScEDxdJeBzcMbBjEW=6ozppGw@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wang Shaoyan <stufever@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, Wang Shaoyan <wangshaoyan.pt@taobao.com>, linux-acpi@vger.kernel.org

Hi Wang,

Yes, I think your description of the race condition is right. However,=20
as Bjorn
mentioned, there are many x86 init paths that will try to reserve the s=
ame
resources as those reported by pnp/acpi. There needs to be a better way=
 to
coordinate legacy device enumeration. Otherwise, the request_region() c=
alls
could fail when there isn't an actual resource conflict.

IF we could find a good way to clean up the legacy users of request_reg=
ion()
then we could probably make pnp behave more like pci with regard to res=
ource
reservations.

Cheers,
Adam

Quoting Wang Shaoyan <stufever@gmail.com>:

> Hi
>
> 2011/8/12 Bjorn Helgaas <bhelgaas@google.com>:
>> We usually funnel PNP stuff through the linux-acpi@vger.kernel.org
>> mailing list, so I added a cc: to it.
>>
>
> Thanks for your reminding!
>
>> request_region() is not a drop-in replacement for __check_region()
>> because __check_region() releases the resource before it returns
>> success. =A0I agree that it would be good to get rid of
>> __check_region(), but I think it's a little more work than just this=
=2E
>>
>> I suppose you could just do the release_resource() in
>> pnp_check_port(), after request_region() was successful. =A0But the
>> problem with __check_region() is that it's racy, and moving the
>> release_resource() into pnp_check_port() doesn't remove the race. =A0=
It
>> just moves the problem from __check_region() (which is easy to grep
>> for) into PNP (where it's not so obvious).
>>
>
> I don't think the racy is still exist. In old days, the racy is exist
> in this situation:
> check_region()
> ...do something    <-- here another process may do check and request=20
> same region
> request_region()   <-- if some process request the same resource, it
> will fail here
>
> But nowadays, request_region has replaced the check_region, it will
> check and request in the same function, so no racy still exist. Am I
> right?
>
>> Part of the problem is that the PNP core doesn't actually request an=
y
>> of the resources used by PNP devices. =A0The PCI core *does* reserve
>> resources, independent of any drivers, and it would certainly be
>> reasonable to expect the PNP core to do the same, but it doesn't.
>> This is mostly because there are a bunch of hardcoded legacy resourc=
es
>> that conflict with PNP devices, and we haven't figured out a good wa=
y
>> to resolve the conflicts.
>>
>> Bjorn
>>
>
>
>
> --
> Wang Shaoyan
>


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
