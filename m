From: "Yu, Ling L" <ling.l.yu@intel.com>
Subject: RE: ACPI home page updates
Date: Fri, 2 Nov 2007 09:29:51 +0800
Message-ID: <14B8575781A1414FA0D4F6649C4D71909D6FAD@pdsmsx415.ccr.corp.intel.com>
References: <CFF307C98FEABE47A452B27C06B85BB604029F11@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:11268 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752771AbXKBBaB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Nov 2007 21:30:01 -0400
Content-class: urn:content-classes:message
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB604029F11@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

Okey. I will work for it and reply again once I finish it.

Thanks
-Ling
>-----Original Message-----
>From: Brown, Len
>Sent: 2007=C4=EA11=D4=C21=C8=D5 23:51
>To: Yu, Ling L
>Cc: linux-acpi@vger.kernel.org
>Subject: ACPI home page updates
>
>Yu-Ling,
>
>Now that the new Linux/ACPI project home page is up at
>http://www.lesswatts.org/projects/acpi/, and MAINTAINERS
>points to it, it is time to update the legacy home page.
>
>The principle of "two copies of the truth" tells us that
>we should delete the redundant info from the old page
>and refer to the (properly maintained) new one.
>
>However, we should retain (and properly label) the
>content on the old page that will continue to live there.
>
>http://acpi.sourceforge.net/index.html
>
>replace all content with this text:
>
>"The Linux/ACPI project home page has moved to
>http://www.lesswatts.org/projects/acpi/.
>This legacy home page contains only legacy information
>that is useful for historical reference."
>
>maybe "Documentation" should be re-named "Legacy Documentation"...
>
>http://acpi.sourceforge.net/documentation/index.html
>Warn again that this is legacy documentation.
>
>http://acpi.sourceforge.net/documentation/alarm.html
>retain, but warn that /proc/acpi is being replaced
>by interfaces in /sys and new software should not
>look in /proc.
>
>http://acpi.sourceforge.net/documentation/blacklist.html
>delete -- this blacklist is stale -- the one copy
>of the truth is the list in the kernel source.
>
>"FAQ (extern)" link
>delete
>
>http://acpi.sourceforge.net/documentation/howto.html
>retain, but maybe a good idea to note that the
>newest of these documents is 2 years old...
>
>http://acpi.sourceforge.net/documentation/processor.html
>retain, but warn that /proc/acpi is being replaced
>by interfaces in /sys and new software should not
>look in /proc.
>
>http://acpi.sourceforge.net/documentation/sleep.html
>retain, but warn that /proc/acpi is being replaced
>by interfaces in /sys and new software should not
>look in /proc.
>
>http://acpi.sourceforge.net/documentation/thermal.html
>retain, but warn that /proc/acpi is being replaced
>by interfaces in /sys and new software should not
>look in /proc.
>
>http://acpi.sourceforge.net/wiki/index.php
>
>This looks extremely stale and I'm inclined to delete it.
>But I'd like some feedback from the list on
>1. Is there anything there that isn't covered elsewhere?
>2. is a Wiki necessary?  (lesswatts.org will not have one)
>
>http://acpi.sourceforge.net/download.html
>
>delete
>
>http://acpi.sourceforge.net/validation/index.html
>
>Verify that contents are intact at new site, and delete old copy.
>
>http://acpi.sourceforge.net/dsdt/index.php
>
>As I've made clear by now, I believe the existence of the DSDT
>database works AGAINST our cause, not FOR it.  However,
>I think this database should to be retained for historical reference
>and labeled with the proper warnings.
>
>I would advocate that it become read-only, but others may disagree.
>
>http://acpi.sourceforge.net/mailinglists.html
>
>delete
>
>http://acpi.sourceforge.net/links.html
>
>this one is nearly all stale.
>is there anything here that is still useful that isn't on
>thew new page?
>
>(BTW. I want to create a new page for pmtools rather than
> having it in my home directory on kernel.org)
>
>http://acpi.sourceforge.net/contact.html
>
>webmaster is the only unique contact for this page,
>everything else should be on the new site.
>
>thanks,
>-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
