From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH 1/3] Add a generic API for _OSC
Date: Wed, 28 Oct 2009 11:02:12 +0300
Message-ID: <4AE7FA84.1020203@gmail.com>
References: <20091027063637.GA22237@sli10-desk.sh.intel.com> <4AE7174D.8090007@gmail.com> <20091028021930.GA31320@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:14350 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932628AbZJ1ICK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Oct 2009 04:02:10 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1867755fga.1
        for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2009 01:02:14 -0700 (PDT)
In-Reply-To: <20091028021930.GA31320@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>

Shaohua Li =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Tue, Oct 27, 2009 at 11:52:45PM +0800, Alexey Starikovskiy wrote:
>  =20
>> Hi Shaohua,
>>
>> Could you also make it take a spec string as argument, not a prepare=
d
>> byte buffer?
>>    =20
> Hi,
> did you mean take the uuid string as an argument of the API? We can
> add a function to convert a uuid string to binary, but I didn't see
> any benefit to take the string as argument.
>
> Thanks,
> Shaohua
>  =20
Hi,
Well, right now you are programming in machine codes. If you make
mistake, no one will notice, even yourself.
Programming languages were invented to make programs look more readable
by humans, so that they can see mistakes more easily.
=46or the same reason ACPI specification declares UUIDs as strings, whi=
le
having them in AML as byte arrays.
=46unction to convert UUID to byte array already exists, you just need =
to
use it...

Regards,
Alex.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
