From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: standby problem
Date: Tue, 20 Sep 2005 13:31:11 +0800
Message-ID: <59D45D057E9702469E5775CBB56411F171FF64@pdsmsx406>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Randy.Dunlap" <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>
Cc: pavel-AlSwsSmVLrQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>> >
>> >> >> i wanted to know what's mean this error :)
>> >> >>
>> >> >> mrspurr:/home/giskard# echo standby > /sys/power/state
>> >> >> acpi_pm_prepare does not support 1
>> >> >>
>> >> >> means that my laptop doesn't supporto standby mode?
>> >> >
>> >> >Probably yes.
>> >> Is it possible we can just show available pm states in
>> /sys/power/state?
>> >> I think we should report the error earlier before we do actual
>> >> suspend/resume. (maybe pm_ops should have a .supported_states
>> callback
>> >> for all archs) It seems many users are complaining about this
after
>> Len
>> >> deprecated the proc interface.
>> >
>> >Pavel Troller even had a patch, but it was too ugly. Yes, we should
>> >only list available states in /sys/power/state.
>> Ok, how does this one look? Each arch provides a .valid callback.
>
>With this patch, I see in /sys/power/state either:
>standby disk		# if CONFIG_SOFTWARE_SUSPEND=3Dy
>
>or just:
>standby			# if CONFIG_SOFTWARE_SUSPEND=3Dn
>
>Does this mean that my poor old BIOS cannot do STR or did I miss
>a config option?  Yes, I have CONFIG_ACPI_SLEEP=3Dy.
>Is there another config option for STR?
It's interesting one system support standby but not support STR. Your
dmesg will tell us which states the system supports.

Thanks,
Shaohua


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
