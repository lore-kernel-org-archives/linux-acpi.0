From: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Subject: Fw: [Bug 5039] high cpu usage (softirq takes 50% all the time)
Date: Mon, 31 Oct 2005 01:50:58 -0800
Message-ID: <20051031015058.1f4bf5e1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


This bug report has something for everyone!


Begin forwarded message:

Date: Mon, 31 Oct 2005 00:21:21 -0800
From: bugme-daemon-3NddpPZAyC0@public.gmane.org
To: akpm-3NddpPZAyC0@public.gmane.org
Subject: [Bug 5039] high cpu usage (softirq takes 50% all the time)


http://bugme.osdl.org/show_bug.cgi?id=5039





------- Additional Comments From laforge-TgoAw6mPHtdg9hUCZPvPmw@public.gmane.org  2005-10-31 00:15 -------
Ok, some comments:

1) I also see the "50% cpu usage" problem on my Turion64.  I fix this (and many
other ACPI related problems) by passing "acpi=off" to the kernel command line. 
The only remaining problem now is that the clock runs at roughly thrice the
speed, i.e. a second only lasts one third of a second ;) [just a side note]
This 'turion64' problem shows 49-51% cpu usage at all time, constantly, no
fluctuation.  Oprofile indicated that it was somewhere in the ACPI idle handling
code.  Didn't have the time for any more debugging. This is totally unrelated to
 iptables, however.

2) iptables processing runs like almost all of the network stack in softirq
context.  So if you have many rules (probably even in a not very much optimized
layout), and high bandwith, it's not unlikely that you spend a significant
amount of time in softirq context, especially on dedicated firewalls and the
like.  This usage should have an almost linear dependency on the number of
packets per second the system processes.  Also, the system from bug reporter
'migo' has a number of tc filter rules, it runs connection tracking (and all
runs in softirq).  So besides 'iptables shall be optimized further', I don't
really see why this should be a bug.

3) why does 'migo' profile show "ct_get_next" in the profile?  This looks like
somebody is constantly reading /proc/net/ip_conntrack from userspace (which is
an _extremely_ expensive operation that should only happen for debugging).  If
you need that information, use ip_conntrack_netlink and libnetfilter_conntrack.

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
