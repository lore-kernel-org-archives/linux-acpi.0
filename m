From: Corentin Chary <corentin.chary@gmail.com>
Subject: wmidump.c: a small tool to dump _WDG
Date: Sun, 11 Apr 2010 17:26:50 +0200
Message-ID: <w2q71cd59b01004110826h7ddeb906re10409848656bf7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>
Cc: Yong Wang <yong.y.wang@linux.intel.com>, Matthew Garrett <mjg@redhat.com>, Carlos Corbacho <carlos@strangeworlds.co.uk>
List-Id: linux-acpi@vger.kernel.org

Hi,
While trying to understand how wmi work (in fact, it's very easy :) ),
I wrote a small utility to dump _WDG.
It's really usefull to see what GUID are present in a dsdt when you
don't have the hardware and to find the
object_id associated with this GUID.

You can grab it here: http://xf.iksaif.net/dev/wmidump.html

I mostly stole some code from wmi.c and added some printf :).

-- 
Corentin Chary
http://xf.iksaif.net
