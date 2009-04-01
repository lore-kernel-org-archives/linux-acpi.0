From: "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>
Subject: Re: [Bugme-new] [Bug 12994] New: Thinkpad R51e is overheating even when
 idle
Date: Wed, 01 Apr 2009 18:16:30 -0300
Message-ID: <1238620590.21668.1308498203@webmail.messagingengine.com>
References: <bug-12994-10286@http.bugzilla.kernel.org/>
 <20090401124744.951c9443.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:58488 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754418AbZDAVQc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 1 Apr 2009 17:16:32 -0400
In-Reply-To: <20090401124744.951c9443.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org

On Wed, 01 Apr 2009 12:47 -0700, "Andrew Morton" <akpm@linux-foundation=
=2Eorg> wrote:
> (switched to email.  Please respond via emailed reply-to-all, not via=
 the
> bugzilla web interface).

You do that, I lose track of things.  So I am going to reply in the bug=
zilla
interface.  Sorry about that.

Maybe someday we could have a proper bug tracker setup that lets one de=
al
with the bug reports over email...  adding magic hidden approval header=
s to
keep random spam at bay is trivial.

Executive summary: AFAIK, that thinkpad might be having hardware proble=
ms.
IBM Thinkpads are supposed to operate at full number-crunching mode at =
full
speed at any decent ambient temperature (in my experience, the T4x will=
 deal with
full load at <35=B0C ambient temps for long periods of time just fine, =
but they
will be quite hot inside (CPU around 75=B0C, likewise the GPU, rest of =
the system
approaching 60=B0C).

Thermal sink problems are common on IBM thinkpads, and are easy to fix =
if you
can deal with taking it apart, cleaning things up, and applying a new t=
hermal
compound.

--=20
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
