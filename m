From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [patch 04/10] acpi: adjust_acpi_{module,function}_namedefinitions
Date: Tue, 6 May 2008 10:36:07 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B348BB38@orsmsx415.amr.corp.intel.com>
References: <200805010952.m419q3Jc031806@imap1.linux-foundation.org> <1209722812.22514.28.camel@linux-2bdv.site> <20080502054113.4e5839d9.akpm@linux-foundation.org> <1209737075.22514.79.camel@linux-2bdv.site> <9D39833986E69849A2A8E74C1078B6B3446FBD@orsmsx415.amr.corp.intel.com> <1210078264.4802.1.camel@linux-2bdv.site>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:2810 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760561AbYEFRhI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 May 2008 13:37:08 -0400
Content-class: urn:content-classes:message
In-Reply-To: <1210078264.4802.1.camel@linux-2bdv.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi@vger.kernel.org, jbeulich@novell.com, "Brown, Len" <len.brown@intel.com>

This is now fixed, thanks.
Bob


>-----Original Message-----
>From: Thomas Renninger [mailto:trenn@suse.de]
>Sent: Tuesday, May 06, 2008 5:51 AM
>To: Moore, Robert
>Cc: linux-acpi@vger.kernel.org; jbeulich@novell.com; Brown, Len
>Subject: RE: [patch 04/10] acpi:
>adjust_acpi_{module,function}_namedefinitions
>
>
>On Sun, 2008-05-04 at 12:14 -0700, Moore, Robert wrote:
>> >But in future, such patches should definitely be based against
ACPICA
>> >code. Len will probably announce here where to find the very latest
>> >sources, soon. Currently the latest official release linked to on
>> >http://lesswatts.org is still from 2006. AFAIK things will get
better
>> >here, soon.
>> >
>> >   Thomas
>>
>>
>> The latest ACPICA source can be found at the acpica.org website. In
>> fact, we have converted our source repository from CVS to git, and
the
>> actual working git repository is now publicly available at
>>
>> http://www.acpica.org/repos/acpica.git/
>>
>> The acpica.org website was created at the end of 2007, and is now the
>> home of the acpica project.
>
>Great!
>You should update the acpica link on the lesswatts.org site:
>http://www.lesswatts.org/downloads
>which still points to:
>http://developer.intel.com/technology/iapc/acpi/downloads.htm
>
>
>   Thomas

