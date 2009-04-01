From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 12994] New: Thinkpad R51e is overheating even
 when idle
Date: Wed, 1 Apr 2009 12:47:44 -0700
Message-ID: <20090401124744.951c9443.akpm@linux-foundation.org>
References: <bug-12994-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47390 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754880AbZDATuC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Apr 2009 15:50:02 -0400
In-Reply-To: <bug-12994-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: bugme-daemon@bugzilla.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Wed, 1 Apr 2009 09:51:15 GMT
bugzilla-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=12994
> 
>            Summary: Thinkpad R51e is overheating even when idle
>            Product: Power Management
>            Version: 2.5
>     Kernel Version: 2.6.28,2.6.29
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Other
>         AssignedTo: power-management_other@kernel-bugs.osdl.org
>         ReportedBy: uzytkownik2@gmail.com
>         Regression: No
> 
> 
> Thinkpad R51e is overheating very much even when idle except when run on 128
> MHz (please see also bug #12826). AFAIR it is not preset on Windows and some
> earielr version of Linux (both I'll check out today).
> 
> The only way of preventing this to happen is to set by thinkpad_acpi fan
> controll to full-speed (i.e. removing the safety settings).
> 

Could someone please recategorize this report appropriately?

(oh, and fixing it would be nice too :))
