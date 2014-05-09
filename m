From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH] ACPI/Battery: Accelerate battery resume callback
Date: Fri, 09 May 2014 15:43:57 +0800
Message-ID: <536C873D.8030405@intel.com>
References: <1399183626-13152-1-git-send-email-tianyu.lan@intel.com> <20140509073827.GA4965@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140509073827.GA4965@xo-6d-61-c0.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 2014=E5=B9=B405=E6=9C=8809=E6=97=A5 15:38, Pavel Machek wrote:
> Hi!
>=20
>> Most time of battery resume callback is spent on executing AML code
>> _BTP, _BIF and _BIF to get battery info, status and set alarm. These
>> AML methods may access EC operation regions several times and consum=
es
>> time.
>>
>> These operations are not necessary during devices resume and can run
>> during POST_SUSPEND/HIBERNATION event when all processes are thawed.
>=20
> Does it mean that userspace will see pre-hibernation battery level fo=
r a while=20
> after resume?

Hi Pavel:
	Thanks for your review. No, when user access the battery sysfs
interface, driver will read battery info and return new data.

>=20
> 									Pavel
>=20


--=20
Best regards
Tianyu Lan
