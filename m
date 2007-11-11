From: "Jim Qode" <jimqode@gmail.com>
Subject: Sony VGN-N395E incompatibility
Date: Sun, 11 Nov 2007 21:22:40 +0200
Message-ID: <c421c8de0711111122r73b22d84rb2c087747849c690@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.228]:4238 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341AbXKKTWq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Nov 2007 14:22:46 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1095546wxd
        for <linux-acpi@vger.kernel.org>; Sun, 11 Nov 2007 11:22:40 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I recently bought a Sony VGN-N395E Laptop. I'm using Ubuntu Gutsy as
the operating system. Laptop runs too hot (about 65-69C) and fan never
kicks in.
Spicctrl does not run correctly. All readings return 0 (zero).

/proc/acpi/fan is empty. There is no fan control
/proc/acpi/thermal_zone has two zones. temperature files always read
49-51 C no matter how hot laptop runs. I assume lmsensors show the
correct reading. trip_points file show only passive cooling option and
tripping point is set to 80C, way too high.
I can't write to tripping_points, i get "bash: echo: write error:
Invalid argument".

I think this laptop has a different variant of the chip Mattia reverse
engineered. This is a really big headache for me, can it be fixed? I
can provide any information you want about the laptop.

Here is the dmesg output => http://paste.ubuntu-nl.org/44159/
And dmidecode output => http://paste.ubuntu-nl.org/44160/

Please let me know if you need anything else.
