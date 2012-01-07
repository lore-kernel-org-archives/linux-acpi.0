From: Konrad Rzeszutek Wilk <konrad@darnok.org>
Subject: Re: [PATCH v2 1/4] ACPI: EC: Add ec_get_handle()
Date: Sat, 7 Jan 2012 15:55:35 -0500
Message-ID: <CAPbh3rv86E9zqUbF4vrA2G=FaXyNHqD7+NZXRkzrzYAsHL8a_Q@mail.gmail.com>
References: <1325617358-8286-1-git-send-email-seth.forshee@canonical.com>
	<1325617358-8286-2-git-send-email-seth.forshee@canonical.com>
	<CAPbh3ruqMQ8UFSehm7vX5i8YWzRFwF5=TX_f4n4dVkvmQa9Njw@mail.gmail.com>
	<20120105193436.GC25386@ubuntu-macmini>
Reply-To: konrad@darnok.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20120105193436.GC25386@ubuntu-macmini>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad@darnok.org>, Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org, Azael Avalos <coproscefalo@gmail.com>, platform-driver-x86@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jan 5, 2012 at 2:34 PM, Seth Forshee <seth.forshee@canonical.co=
m> wrote:
> On Thu, Jan 05, 2012 at 01:27:08PM -0500, Konrad Rzeszutek Wilk wrote=
:
>> 8
>> On Jan 3, 2012 2:05 PM, "Seth Forshee" <seth.forshee@canonical.com> =
wrote:
>> >
>> > toshiba_acpi needs to execute an AML method within the EC namespac=
e
>> > to make hotkeys work on some platforms. Provide an interface to
>> > allow it to easily get a handle to the EC namespace for this purpo=
se.
>> >
>> > Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
>> > ---
>> > =A0drivers/acpi/ec.c =A0 =A0| =A0 10 ++++++++++
>> > =A0include/linux/acpi.h | =A0 =A01 +
>> > =A02 files changed, 11 insertions(+), 0 deletions(-)
>> >
>> > diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>> > index b19a18d..e37615f 100644
>> > --- a/drivers/acpi/ec.c
>> > +++ b/drivers/acpi/ec.c
>> > @@ -445,6 +445,16 @@ int ec_transaction(u8 command,
>> >
>> > =A0EXPORT_SYMBOL(ec_transaction);
>> >
>> > +/* Get the handle to the EC device */
>> > +acpi_handle ec_get_handle(void)
>> > +{
>> > + =A0 =A0 =A0 if (!first_ec)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> > + =A0 =A0 =A0 return first_ec->handle;
>> > +}
>> > +
>> > +EXPORT_SYMBOL(ec_get_handle);
>>
>> shouldn't this be _GPL?
>
> I don't know. All the other ec_* interfaces are EXPORT_SYMBOL, so I d=
id
> likewise. I'm happy to change it if _GPL is what ought to be used her=
e.

My understanding (and this is from reading Greg KH's patches) is that
any new interface should use _GPL variant unless there is an absolute
need for it. Say, a binary driver that uses this function and there is
no other way around it.

>
