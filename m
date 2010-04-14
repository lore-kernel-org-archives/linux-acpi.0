From: "Justin P. mattock" <justinmattock@gmail.com>
Subject: Re: [acpi:battery?] kernel oops on boot
Date: Wed, 14 Apr 2010 08:16:04 -0700
Message-ID: <4BC5DC34.2010004@gmail.com>
References: <20100414095750.GA3304@swordfish.minsk.epam.com> <20100414131324.GA6598@nb-core2.darkstar.lan> <alpine.LFD.2.00.1004141641010.3640@terrop> <4BC5CA13.3070801@suse.de> <alpine.LFD.2.00.1004141704350.1535@terrop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1004141704350.1535@terrop>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Roponen <tero.roponen@gmail.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Luca Tettamanti <kronos.it@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org

On 04/14/2010 07:05 AM, Tero Roponen wrote:
>
> On Wed, 14 Apr 2010, Alexey Starikovskiy wrote:
>
>> 14.04.2010 17:50, Tero Roponen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>
>>> On Wed, 14 Apr 2010, Luca Tettamanti wrote:
>>>
>>>> Hello,
>>>> I'm seeing a similar bug on my notebook (Asus F3Sa) with current g=
it.
>>>> -rc4 does not work, while -rc3 does work.
>>>>
>>>> The error (at least in my case) is a division by zero in
>>>> acpi_ex_insert_into_field.
>>>
>>> I have a similar problem with Asus M50Vm. git-bisect found
>>> the following commit and reverting it does indeed fix the
>>> problem.
>>>
>>> commit dadf28a10c3eb29421837a2e413ab869ebd9e168
>>> Author: Alexey Starikovskiy<astarikovskiy@suse.de>
>>> Date:   Wed Mar 17 13:14:13 2010 -0400
>>>
>>>       ACPI: EC: Allow multibyte access to EC
>>>
>>>       http://bugzilla.kernel.org/show_bug.cgi?id=3D14667
>>>
>>>       Signed-off-by: Alexey Starikovskiy<astarikovskiy@suse.de>
>>>       Signed-off-by: Len Brown<len.brown@intel.com>
>>>
>> Please see the patch in https://bugzilla.kernel.org/show_bug.cgi?id=3D=
15749
>
> Work for me. Thanks.
>
> Tested-by: Tero Roponen<tero.roponen@gmail.com>


same here(just posted the Oops).
patch works:

Tested-by: Justin P. Mattock <justinmattock@gmail.com>

I actually was getting excited to do a bisect
(I'm a glutton for pain!!).

Justin P. Mattock
