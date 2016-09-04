From: Al Stone <ahs3@redhat.com>
Subject: [RFC DSD v3 04/04] ChangeLog
Date: Sun, 4 Sep 2016 14:36:18 -0600
Message-ID: <340debfb-1be8-a511-9ebf-ba6a114524a4@redhat.com>
References: <16c080d3-9106-e1f3-e65a-e0d8aaf1b01e@redhat.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:37154 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753901AbcIDUgU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Sep 2016 16:36:20 -0400
Received: by mail-it0-f54.google.com with SMTP id e124so120363640ith.0
        for <linux-acpi@vger.kernel.org>; Sun, 04 Sep 2016 13:36:19 -0700 (PDT)
In-Reply-To: <16c080d3-9106-e1f3-e65a-e0d8aaf1b01e@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "Hart, Darren" <darren.hart@intel.com>

===== v0.0.12 ==========================================================

Parser/Tools:
=============
-- None; need to be cross-checked against documentation

Documentation:
==============
-- From Darren Hart:
   -- Correct language to forbid overriding property definitions via
      inheritance
   -- Correct revision number examples to remove not-a-number examples
   -- Clarify property set revision rules

===== v0.0.11 ==========================================================

Parser/Tools:
=============
-- Updated the tools to reflect the documentation changes below

Documentation:
==============
-- [Robert Gough] db doc:
>>> Section 2.1, I believe the top level directories should not be vendors,
>>> but bus types. The next level would then be vendors, based on the
>>> bus-assigned Vendor ID. For example, bus types would include ACPI, PCI,
>>> USB, etc. Subdirectories would then be bus-specific. So for example,
>>> Intel would own properties under ACPI/INTC and PCI/0x8086. This would
>>> provide an unambiguous mechanism for determining ownership of property
>>> definition.
	-- changed in database_rules.txt

-- [Robert Gough] db doc:
>>> In section 2.2, I believe the requirement for "00-base-sets" as well as
>>> the '/' character should be removed from this doc and included in the
>>> 0003-formal-language document, but I haven't gotten there yet.
	-- changed in database_rules.txt
	-- removed the mention of 00-base-sets as an implementation
	   detail; there's no real need for us to specify that level
	   of info to be used by the tools.

-- Explain clearly that "derives-from: B, C" implies an order of use for
>> common names -- e.g., that B/foo takes precedence over C/foo, which will
>> be ignored.
	-- changed in database_rules.txt

-- Consensus: overriding a property definition is not allowed.
	-- stated explicitly in database_rules.txt
	-- stated explicitly in formal_language.txt

-- [Robert Gough] db doc:
>>> Furthermore, I'd like to suggest that using a different scheme for
>>> versioning may be more useful. It may make sense for a given property
>>> set to map to a specification which uses versioning beyond simple
>>> integers, and it may be preferable to have those versions match the
>>> property set versions; so something like 1.3.5 or 0x01030500, for a
>>> major.minor.secondary.tertiary scheme, or something like this <solicit
>>> discussion...>. Also, to go along with this, in section 4 I would
>>> recommend stating that any "new revision" must be greater than any
>>> previously defined revision- such that one cannot create version 1.3.1
>>> after version 1.4 has been defined.
	-- relaxed the definition of a revision string to be any C
	   integer string (0x0, 007, 0b01000010) -- for example,
	   20150419, 0x01030500, 1.5.3.1, 12
	-- added proper text to database_rules.txt
	-- added proper text to formal_language.txt

-- Consensus: amendments to the text on making changes need to say:
>>
>> (1) *No* changes to an accepted property set is too strict.
>>
>> (2) Changes to a property set are only allowed in new revisions.
>>
>> (3) Changes to an accepted property set are allowed if either:
>>
>>     (a) The change is an obvious typographical error, or,
>>
>>     (b) The change is an erratum, meant to correct the property set
>>         so that it accurately reflects shipping firmware, or,
>>
>>     (c) The change is to an existing data validation rule to make it
>>         stricter, which ensures we maintain backwards compatibility.
>>         The change cannot not change the types of values, or allow
>>         for a broader range of values.
	-- added the text above to process_rules.txt
	-- added pointer to the text above in process_rules.txt to
	   database_rules.txt
	-- minor rewrites, but content remains the same



-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
