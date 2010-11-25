From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: debugfs_create_dir return value in acer-wmi, intel_ips and ec_sys
Date: Thu, 25 Nov 2010 07:40:23 +0100
Message-ID: <AANLkTikuHbF5FLT4OB8koZRgQkd5Ye7+O6HLrCY_vnq-@mail.gmail.com>
References: <4ceda4f7.0cedd80a.26b4.0222@mx.google.com>
	<Pine.LNX.4.64.1011250653370.15506@ask.diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:45043 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab0KYGkZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Nov 2010 01:40:25 -0500
In-Reply-To: <Pine.LNX.4.64.1011250653370.15506@ask.diku.dk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Matthew Garrett <mjg@redhat.com>, Axel Lin <axel.lin@gmail.com>, Thomas Renninger <trenn@suse.de>

On Thu, Nov 25, 2010 at 7:01 AM, Julia Lawall <julia@diku.dk> wrote:
> On Thu, 25 Nov 2010, Corentin Chary wrote:
>
>> Hi,
>>
>> I was checking debugfs code in platform/x86, because I want to add
>> some files to eeepc-wmi. And I found something disturbing.
>>
>> The documentation says:
>>
>> > This call, if successful, will make a directory called name undern=
eath the
>> > indicated parent directory. =C2=A0If parent is NULL, the directory=
 will be
>> > created in the debugfs root. =C2=A0On success, the return value is=
 a struct
>> > dentry pointer which can be used to create files in the directory =
(and to
>> > clean it up at the end). =C2=A0A NULL return value indicates that =
something went
>> > wrong. =C2=A0If ERR_PTR(-ENODEV) is returned, that is an indicatio=
n that the
>> > kernel has been built without debugfs support and none of the func=
tions
>> > described below will work.
>>
>> But then, here is the code in acer-wmi:
>>
>> > static void remove_debugfs(void)
>> > {
>> > =C2=A0 =C2=A0 =C2=A0 debugfs_remove(interface->debug.devices);
>> > =C2=A0 =C2=A0 =C2=A0 debugfs_remove(interface->debug.root);
>> > }
>> >
>> > static int create_debugfs(void)
>> > {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0interface->debug.root =3D debugfs_creat=
e_dir("acer-wmi", NULL);
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!interface->debug.root) {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(ACER=
_ERR "Failed to create debugfs directory");
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENO=
MEM;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> this code is *not* inside #ifndef CONFIG_DEBUG_FS, so debugfs_create=
_dir
>> can return ERR_PTR(-ENODEV) right ?
>>
>> Then, remove_debug() will call debugfs_remove(ERR_PTR(-ENODEV)) righ=
t ?
>>
>> So, acpi-wmi seems to have an issue when debugfs is disabled, that's=
 "ok".
>>
>> But then I took a look at intel_ips :
>>
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0ips->debug_root =3D debugfs_create_dir(=
"ips", NULL);
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ips->debug_root) {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&ip=
s->dev->dev,
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0"failed to create debugfs entries: %ld\n",
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0PTR_ERR(ips->debug_root));
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> Then PTR_ERR thing is strange, because ips->debug_root can only be N=
ULL
>> here...
>> But here, it's ok to only check NULL, because it's inside #ifndef
>> CONFIG_DEBUG_FS.
>>
>> So, two drivers checked, to weird error handling code. I did a quick=
 grep and
>> opened
>> the first result: ec_sys.c.
>>
>> ec_sys.c depends on CONFIG_ACPI_EC_DEBUGFS but doesn't depend on
>> CONFIG_DEBUG_FS.
>>
>> Here, again, the code only check for !=3D NULL while it could be ERR=
_PTR(-
>> ENODEV):
>>
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ec_device_count =3D=3D 0) {
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_ec_deb=
ugfs_dir =3D debugfs_create_dir("ec", NULL);
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!acpi_e=
c_debugfs_dir)
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return -ENOMEM;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0sprintf(name, "ec%u", ec_device_count);
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dir =3D debugfs_create_dir(name, ac=
pi_ec_debugfs_dir);
>>
>> Here, acpi_ec_debugfs_dir (that can be an invalid pointer) is used a=
s
>> a parent dentry, and will be dereferenced without checks.
>>
>> I am missing something obvious, or are most of debugfs implementatio=
n
>> broken when debugfs is disabled ?

Answer to myself, when debugfs is disabled, it's ok to give broken
dentry pointers to debugfs functions since they won't do anything.

>> Julia, if I am right, coccinelle could help us right ? Can the tool =
check
>> if the code is between #ifdef CONFIG_DEBUGS_FS ? That would help a l=
ot.
>
> Unfortunately, at the moment, it can't; there is no matching on #ifde=
fs.
> Perhaps it could be added.

Or better, something to check if a macro is defined in a particular con=
tact ?

> I wonder though if sometimes returning NULL and sometimes returning
> ERR_PTR is something that should be encouraged? =C2=A0Would one rathe=
r convert
> the NULL case to a specific ERR_PTR case?

But yeah, I found debugfs API disturbing, but it seems to be done like =
that to
ease the "debugfs is disabled case".

Thanks,
--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
