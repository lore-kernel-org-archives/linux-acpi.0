From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] battery: Fix charge_now returned by broken batteries
Date: Sat, 10 Oct 2009 23:44:42 +0200
Message-ID: <ca2dc2820910101444v16b44645se826ae2bfbdb90a3@mail.gmail.com>
References: <4AC8F02B.6080209@suse.de> <4AC91578.2020807@suse.de>
	 <ca2dc2820910041455h18ece909rc2280a40f1899c0a@mail.gmail.com>
	 <4AC923F4.9050100@suse.de>
	 <ca2dc2820910041653o29d4b253n69270d231e56e447@mail.gmail.com>
	 <4AC93B45.8090707@suse.de>
	 <ca2dc2820910061005k2beae176lece9792bb15cda90@mail.gmail.com>
	 <20091010120448.GB1811@ucw.cz>
	 <ca2dc2820910101353g65e4591ds82bf9fff8378abd4@mail.gmail.com>
	 <20091010212521.GD14051@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757292AbZJJVpW@vger.kernel.org>
In-Reply-To: <20091010212521.GD14051@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Oct 10, 2009 at 11:25 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> >> In "broken" batteries (is it broken finally? or is it expected
>> >> behaviour?) like mine the old problem will be corrected, as it wa=
s
>> >> only present in the charged state.
>> >
>> > I believe you better work around this in userspace... or agree tha=
t
>> >>100% charge is possible.
>>
>> I agree that >100% charge is possible while charging (because that
>> would mean the battery is over the last charged level); however, wha=
t
>> does it mean when charged?
>
> Well, maybe the battery only updates full_charge_capacity during
> powerdown or when the moon is full or something? (IOW you may be
> breaking already working machines).
>

I do not know about batteries as I said, I was waiting for someone to
point out how batteries (normally/should) work.

>> In any case, my laptop's battery is not charging over 100% its
>> original capacity anyway, just reporting a wrong value.
>
> True. But I do not think =A0you are fixing it properly. Maybe ask for
> fixed BIOS?

Well, many BIOS/systems are broken and Linux has to workaround them. I
am sure there are a lot of broken batteries out there.

>
> Or perhaps add quirk based on DMI or something?

My battery is easily identified by its model name, so maybe we can
apply the workaround only to known hardware. Still, that is a "heavy"
solution, as I suppose there are many many battery models in the
world. That is why I was asking whether some kind of standard/unified
batteries' values/behavior exists (or implement it) that we can try to
achieve easily with some heuristics like the one I proposed, instead
of some kind of huge table-based workaround system.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/hors=
es/blog.html
>
