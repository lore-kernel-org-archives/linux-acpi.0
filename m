From: Richard Hughes <hughsient@gmail.com>
Subject: Re: [PATCH] toshiba_acpi: Add full hotkey support
Date: Sat, 7 Mar 2009 20:19:51 +0000
Message-ID: <15e53e180903071219q4ed318edt2fa8f492426c0ab6@mail.gmail.com>
References: <20090306003941.GA32403@srcf.ucam.org>
	<E1LfqwF-000B1G-00.arvidjaar-mail-ru@mx3.mail.ru>
	<20090307150640.GA3516@srcf.ucam.org>
	<200903071839.16508.arvidjaar@mail.ru>
	<20090307154424.GA3909@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <hal-bounces@lists.freedesktop.org>
In-Reply-To: <20090307154424.GA3909@srcf.ucam.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/hal>
List-Post: <mailto:hal@lists.freedesktop.org>
List-Help: <mailto:hal-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/hal>,
	<mailto:hal-request@lists.freedesktop.org?subject=subscribe>
Sender: hal-bounces@lists.freedesktop.org
Errors-To: hal-bounces@lists.freedesktop.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, hal@lists.freedesktop.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Mar 7, 2009 at 3:44 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Sat, Mar 07, 2009 at 06:38:53PM +0300, Andrey Borzenkov wrote:
>
>> - patch toshiba_acpi to return KEY_SUSPEND/KEY_HIBERNATE instead of
>> KEY_SLEEP/KEY_SUSPEND. This depends on commit
>> 6932b918e05b06165ed3457a9f3aa279099a7cbd in linux-next.
>>
>> - patch HAL to recognize KEY_HIBERNATE and return "suspend" for
>> KEY_SUSPEND; right now it is:
>>
>> =A0 =A0 =A0 =A0 [KEY_SLEEP] =3D "sleep",
>> =A0 =A0 =A0 =A0 [KEY_SUSPEND] =3D "hibernate",
>
> Ugh. Why are we changing this? The semantics were pretty clear before.
> The KEY_SUSPEND to hibernate mapping was decided years ago, and it's
> clearly an incompatible change as far as userspace goes.

See my mails to linux-acpi. Hibernate =3D sleep to disk, suspend =3D sleep
to ram, and sleep =3D sleep type not indicated or unknown. This is how
it is in Xorg and the session now.

Mapping KEY_SUSPEND to hibernate is just insane. Can you please change
the toshiba driver to use KEY_HIBERNATE and KEY_SUSPEND as thinkpad
now does? Thanks.

Richard.
