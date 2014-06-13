From: Kalle Valo <kvalo@adurom.com>
Subject: Re: [Intel-gfx] video: X sets brightness to zero after resume
Date: Fri, 13 Jun 2014 10:35:15 +0300
Message-ID: <87wqclz2h8.fsf@purkki.adurom.net>
References: <871tuu1epc.fsf@purkki.adurom.net> <539A53B3.6030902@intel.com>
	<539AA863.6070806@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <539AA863.6070806@redhat.com> (Hans de Goede's message of "Fri,
	13 Jun 2014 09:29:39 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Aaron Lu <aaron.lu@intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> writes:

>>> If I set video.use_native_backlight=0 in kernel command line the problem
>>> goes away. Or if I revert your commit 0e9f81d3b7c the problem also goes
>>> away. Any ideas?
>> 
>> Not really...
>> I've added i915 people maybe they have an idea.
>
> This is a known issue in xf86-video-intel, which gets exposed due to the
> video.use_native_backlight=1 option. This should be fixed in the latest 2.99.912
> xf86-video-intel release.

Ok, thanks. As Ubuntu 12.04 doesn't have that I'll continue to use
video.use_native_backlight=0 until I update my distro.

-- 
Kalle Valo
