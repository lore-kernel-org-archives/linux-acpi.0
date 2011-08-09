From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: [PATCH v3 0/2] Forcibly enable some MISC_ENABLE features on Intel
Date: Tue, 9 Aug 2011 09:09:34 -0400
Message-ID: <CAObL_7G5j-8dmQDc2Q+matB8nHk7421CWnBHqQs9-T2fjVecng@mail.gmail.com>
References: <cover.1312893572.git.luto@mit.edu> <20110809135050.79eed316@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:53469 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051Ab1HINJy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Aug 2011 09:09:54 -0400
In-Reply-To: <20110809135050.79eed316@lxorguk.ukuu.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>

On Tue, Aug 9, 2011 at 8:50 AM, Alan Cox <alan@lxorguk.ukuu.org.uk> wro=
te:
> On Tue, =A09 Aug 2011 08:41:04 -0400
> Andy Lutomirski <luto@MIT.EDU> wrote:
>
>> Intel allows BIOS or the OS to enable or disable some CPU fueatures =
via
>> IA32_MISC_ENABLE. =A0I have machines that don't enable fast strings =
or
>> monitor/mwait in BIOS, so do it on bootup instead.
>
> The question is - why.
>
>> The Intel SDM volume 3, appendix B.1 says that the OS should not tou=
ch
>> the monitor enable bit if SSE3 is not present, which presumably mean=
s
>> that the OS may touch that bit if SSE3 is present. =A0In any case, t=
hese
>> patches seem to work.
>
> That's a big "presumes"
>
> For example back in Pentium days the BIOS sometimes turned off a stri=
ng
> fast path because it was subtly not reliable on certain parts and cou=
ld
> corrupt.
>
> It's possible your BIOS vendor has a good reason for doing this. It's
> also possible its a bug, or a left over perhaps from some pre-release
> processor or something.

Intel also says:

  However, Intel recomments that system software always enable
  fast-string operation.

On my machine it's definitely a bug.  It's a Sandy Bridge box (from
Intel) and with TXT disabled the BIOS enables fast strings on its own.

=46enghua, do you know if there are any machines that will pass the
version checks and will actually allow fast strings to be enabled but
that will have problems as a result?

If we want to be conservative, we could limit it to the most recent
family 6 devices and exclude family 0xf entirely.

--Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
