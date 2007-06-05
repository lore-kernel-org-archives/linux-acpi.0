From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [2/5] 2.6.22-rc4: known regressions
Date: Tue, 05 Jun 2007 16:43:48 +0200
Message-ID: <466576A4.30701@googlemail.com>
References: <46657407.1000108@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:32503 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765194AbXFEOoE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jun 2007 10:44:04 -0400
Received: by ug-out-1314.google.com with SMTP id j3so192423ugf
        for <linux-acpi@vger.kernel.org>; Tue, 05 Jun 2007 07:44:03 -0700 (PDT)
In-Reply-To: <46657407.1000108@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Thierry Volpiatto <tvolpiatt@neuf.fr>, Marc Tuerschmann <marc@tuerschmann.de>, Denis Sadykov <denis.m.sadykov@intel.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, Ben Collins <bcollins@ubuntu.com>, linux-fsdevel@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>

Hi all,

Here is a list of some known regressions in 2.6.22-rc4.

=46eel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



ACPI

Subject    : ACPI_CPUFREQ fails to load - HP ML110 G4 Xeon 3040
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8570
Submitter  : Marc Tuerschmann <marc@tuerschmann.de>
Status     : Unknown
             (possible hardware issues)

Subject    : unable to shutdown on kernel 2.6.22-rc2
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8516
Submitter  : Thierry Volpiatto <tvolpiatt@neuf.fr>
Status     : Unknown



ALSA

Subject    : snd-aoa causes badness in lib/kref.c:33
References : http://bugzilla.kernel.org/show_bug.cgi?id=3D8513
Submitter  : Ben Collins <bcollins@ubuntu.com>
Status     : Unknown


=46ile systems

Subject    : OOPS (NULL pointer dereference) in v2.6.22-rc3
References : http://lkml.org/lkml/2007/6/1/389
Submitter  : Alex Riesen <raa.lkml@gmail.com>
Status     : Unknown



Regards,
Michal

--
"Najbardziej brakowa=B3o mi twojego milczenia."
-- Andrzej Sapkowski "Co=B6 wi=EAcej"

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
