From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH 4/5] ACPI, APEI, Fix error path for memory allocation
Date: Thu, 23 Sep 2010 16:53:11 +0800
Message-ID: <AANLkTinkmCJpyj2j2yi3Lj9h2q0mFcWbS4y=AKxerYkz@mail.gmail.com>
References: <1284865235-29920-1-git-send-email-ying.huang@intel.com>
	<1284865235-29920-5-git-send-email-ying.huang@intel.com>
	<20100921124552.GD18991@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100921124552.GD18991@one.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi, Andi,

On Tue, Sep 21, 2010 at 8:45 PM, Andi Kleen <andi@firstfloor.org> wrote=
:
> On Sun, Sep 19, 2010 at 11:00:34AM +0800, Huang Ying wrote:
>> @@ -475,7 +479,13 @@ int apei_resources_request(struct apei_resource=
s *resources,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> - =C2=A0 =C2=A0 apei_resources_merge(&apei_resources_all, resources)=
;
>> + =C2=A0 =C2=A0 rc =3D apei_resources_merge(&apei_resources_all, res=
ources);
>> + =C2=A0 =C2=A0 if (rc) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err(APEI_PFX
>> +"Error in APEI internal resource management, there may be inconsist=
ent "
>> +"between APEI internal and system resource management.");
>
> Please fix the English. This will wrap in the syslog without \ns no?
> Kernel messges should be not wider than 80 characters.
>
>> + =C2=A0 =C2=A0 rc =3D apei_resources_sub(&apei_resources_all, resou=
rces);
>> + =C2=A0 =C2=A0 if (rc)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_err(APEI_PFX
>> +"Error in APEI internal resource management, there may be inconsist=
ent "
>> +"between APEI internal and system resource management.");
>
> Same.
>
> Also instead of Error it would be better just say what is wrong and d=
on't
> try to analyze the problem.

OK, I will do it.

Best Regards,
Huang Ying
