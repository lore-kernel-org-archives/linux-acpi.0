From: Seblu <seblu@seblu.net>
Subject: Re: Bad AC adaptateur value trought sysfst
Date: Tue, 2 Nov 2010 02:50:41 +0100
Message-ID: <AANLkTin=Hq+-H6AA27KU1Suyetibba+HR5tH=TbjHw6M@mail.gmail.com>
References: <AANLkTino-WkpMHfqD6amL-gk5mabiQAVbn9Low8L6joF@mail.gmail.com>
 <1288572245.2234.88.camel@rui> <AANLkTin517i-Ld_rNRxjmt65hiVpT3bC3wCrL43weiu7@mail.gmail.com>
 <1288660595.2234.164.camel@rui>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd184d232279604940828fa
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33044 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398Ab0KBBvC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Nov 2010 21:51:02 -0400
Received: by pwj3 with SMTP id 3so1430804pwj.19
        for <linux-acpi@vger.kernel.org>; Mon, 01 Nov 2010 18:51:02 -0700 (PDT)
In-Reply-To: <1288660595.2234.164.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

--000e0cd184d232279604940828fa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 2, 2010 at 2:16 AM, Zhang Rui <rui.zhang@intel.com> wrote:
> On Tue, 2010-11-02 at 04:10 +0800, Seblu wrote:
>> On Mon, Nov 1, 2010 at 1:44 AM, Zhang Rui <rui.zhang@intel.com> wrote:
>> > will you please attach the acpidump output of this laptop?
>> yes, sure.
>
> does the error message pop up every time you boot the kernel?
If you speak about dmesg error message like the following

ACPI Exception: AE_TIME, Returned by Handler for [EmbeddedControl]
(20101013/evregion-474)
ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPCB.ECDV.ECR1]
(Node ffff880213058c08), AE_TIME (20101013/psparse-537)
ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPCB.ECDV.ECR2]
(Node ffff880213058c30), AE_TIME (20101013/psparse-537)the
ACPI Error: Method parse/execution failed [\ECRW] (Node
ffff880213058d98), AE_TIME (20101013/psparse-537)
ACPI Error: Method parse/execution failed [\ECG1] (Node
ffff880213058de8), AE_TIME (20101013/psparse-537)
ACPI Error: Method parse/execution failed [\NEVT] (Node
ffff88021305a168), AE_TIME (20101013/psparse-537)
ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPCB.ECDV._Q66]
(Node ffff880213058be0), AE_TIME (20101013/psparse-537)

yes, these lines is present at each startup.

>
>> > please try the patch attached to see if it helps.
>> > BTW, the patch is based on today's git tree. and there may be some
>> > conflict if you use 2.6.36 kernel.
>> Right, i join my version to test it on 2.6.35.8.
>>
>> I've tested after many startup (from shutdown or reboot) on 2.6.35.8
>> and on linux-next-2010-10-29 and this seems to fix the issue. Thanks!
>>
> good to know.
> But I'm still confused about this problem.
> you can get the notifications every time you plug or unplug the AC
> adapter, right?
>
> here is how ACPI AC driver works:
> 1. plug/unplug AC
> 2. AC driver receives notification (done by BIOS)
> 3. update the AC status (in notification hander)
> 4. send notification to userspace (in notification handler)
> 5. user space query AC status when receiving the notification
>
thx !

> as we can see, the AC status is already updated in step 3, that's why AC
> driver returns a cached value to user space in step 5.
> But apparently this is broken in your case.
>
> This makes me wondering if BIOS forgets to do step 2, thus AC driver
> does not update the AC status. But you can catch the AC plug/unplug
> event every time which suggest the notification is sent correctly.
>
> Seblu,
> will you please plug and unplug the AC adapter for several times and
> attach the output of "grep . /sys/firmware/acpi/interrupts/*" every time
> you plug or unplug the AC adapter?
>
done with 2.6.37-rc1 and your patch (which fix my screen issue \o/)

--=20
S=E9bastien Luttringer
www.seblu.net

--000e0cd184d232279604940828fa
Content-Type: application/x-gzip; name="plug-test.tar.gz"
Content-Disposition: attachment; filename="plug-test.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gg04gc3s1

H4sIAFBuz0wAA+3dzW7aQBQFYNZ9Cl4gZeZeewzdNU37Gogfg6wasGzTtG9fU1oaZRE8R8IaMudI
EYv4apzYR5hPdmLsw3FflcftNl9/bH+2oxvEdHHGdK+Jqp5ejWbn11Myl2QjaxOnzrksk5GxalId
jc0tduZ1jk27qMfjUZMvy+Mb23Xf31ZD7NCwmTS/msmmqHfPizqfLFZVMSn2bV7Xx6ptJt3rof40
Psd8eHvjzWa+XZbz8rD6fhnpvtZFs1iW+fr6dLVri11evxwu9j8WZdFn9rmeL9v9y9l833Pdup2v
SnCfm7J6vW6/fd5WuTHYmPX/KU9jgq2m2FiCjaXYmMN+JRm22hQbmwGn2GnuM7bcI7jcF2y5J3C5
r9hy36Axe65cmk2tz4liLbYaVjmLVc5ilbNY5azDxrDK2b+VE8/jNsNWwxpnH7ExrHD2CRvD+mYv
ffM6AIK9xQnWN8H6JljfBOubYH0TrG+C9U2wtzjB+iZY3wTrm2B9E6xvgvVNsPc3xfqmWN8U65ti
fVOsb4r1TbG+KdY3xfqmWN8U65tifVOsb4r1TbG+Kda3+aIs/ww64/TK5s2quFx8Xt90vj+0/z95
3+zzv5GHG+sP4j+SWkv/GSL0H/oP/Yf+E5n/TKdTnxOF/hOK/8y8Ck7/of/Qf5Ax+g/9h/4DjNF/
4vQfm836+k938RmO/2ig9/+k9J8hQv+h/9B/6D+R+c9MZz4nCv0nGP9Rr+NG/6H/0H+AMfoP/Yf+
A4zRf+L0H9He9/90F5/h+E8S6P0/fP5rkNB/6D/0H/pPXP7jTOJ8ThT6TyD+o4b+Q/+h/9B/6D/0
H/oP/ScU/9H02ufjf/5zuvgMx3/SQO//yeg/Q4T+Q/+h/9B/IvMfa+k/9+k/fs/t0X/oP/QfYIz+
Q/+h/wBj9J84/SeRtK//dBef4fiPC/T+Hz7/NUjoP/Qf+g/9JzL/EfrPffqPzbyOG/2H/kP/Acbo
P/Qf+g8wRv+J039STfr6j4TkP1mY9/84S/8ZIvQf+g/9h/4Tm/84/v+v+/Qfv7/bRP+h/9B/gDH6
D/2H/gOM0X8i9Z8+/9TrcvEZjv9MA73/h89/DRL6D/2H/kP/icx/VP3uI6H/BOI/kngdN/oP/Yf+
A4zRf+g/9B9gjP4Tp/84J339p7v4DMZ/GIZhGIZhGIZhGIZ5//kNL79VXwCgAAA=
--000e0cd184d232279604940828fa--
