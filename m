From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH 01/30] ACPICA: Linuxize: reduce divergences for 20160212
 release
Date: Tue, 29 Mar 2016 05:37:14 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BB658E2@SHSMSX101.ccr.corp.intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
	 <cc3b66b74c73a66f82cb715092b6f35105a0cbf8.1458714003.git.lv.zheng@intel.com>
	 <1458783966.1762.6.camel@perches.com>
	 <1AE640813FDE7649BE1B193DEA596E883BB63FB7@SHSMSX101.ccr.corp.intel.com>
	 <1458817225.1762.13.camel@perches.com>
	 <1AE640813FDE7649BE1B193DEA596E883BB655F7@SHSMSX101.ccr.corp.intel.com>
 <1459134954.25110.26.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:33354 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751571AbcC2FhT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Mar 2016 01:37:19 -0400
In-Reply-To: <1459134954.25110.26.camel@perches.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joe Perches <joe@perches.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi,

> From: Joe Perches [mailto:joe@perches.com]
> Subject: Re: [PATCH 01/30] ACPICA: Linuxize: reduce divergences for 2=
0160212
> release
>=20
> On Mon, 2016-03-28 at 03:02 +0000, Zheng, Lv wrote:
> > Hi,
>=20
> Hello.
>=20
> > > So why not fix the process script first?
> > > Maybe add something like:
> > > $ grep -E "^typedef\s+\w+\s*\*?\s*acpi_\w+" include/acpi/actypes.=
h | \
> > > =A0 grep -Eoh "\bacpi_\w+"
> > >
> > > to the acpi_types variable in the lindent_single function
> > [Lv Zheng]
> > I don't think this can work given:
> > 1. we are not only dealing with typedefs, but structs, struct xxx w=
ill be
> converted into types during the release process.
> > 2. we have only upper cased type names in ACPICA upstream, but have=
 the
> lower cased type names in Linux, and this doesn't solve that.
> > So I guess you didn't test your idea.
>=20
> Good guess.
>=20
> The "maybe add something like" should give you a clue.
>=20
> > You need to pull ACPICA repo and do the followings to confirm if th=
is is
> working:
>=20
> No, I disagree. =A0_I_ don't need to. =A0You need to.
[Lv Zheng]=20
Then you don't have to provide the solution as you are not the one exec=
uting the process.
I can fix it myself:
https://github.com/acpica/acpica/pull/129=20
It would be merged by the ACPICA upstream in the near future.

I'll show you the difficulties of "process" later.

>=20
> You shouldn't have a process that generates defective patches
> and then sends them to the list.
[Lv Zheng]=20
You are not the one executing this process, so you don't know what's ha=
ppening here.

Actually the Linux repo should be synced to the state of the ACPICA rep=
o.
The defective patch is used for "syncing repo state", not for "fixing i=
ndentation problem" or something else.
So if we merged a "process fixing commit" into ACPICA upstream, you'll =
still have to see such kind of defective patches before this commit bec=
ause of the state synchronization requirement.

There have already been many such indentation conflicts between Linux a=
nd ACPICA.
My current rule on the existing unsynced Linux side code conflict is ba=
sed on the "syncing repo state" purpose:
I'll ignore them as long as no new linuxized ACPICA commits complain me=
rge conflicts.
But if I saw merge conflict to a new linuxized commit, I'll revert the =
Linux side code to the __wrong__ but synced state in a separate patch.
That's why you can see this commit.

As a conclusion, the defective patch is because of the purpose - syncin=
g repo state.
Then why do I use a separate patch?

The separated defective patch is the only patch we need to maintain man=
ually, and all other linuxized ACPICA results needn't be maintained man=
ually.
So you can imagine that we can do the recursive development/testing in =
the ACPICA upstream again and again.
And the linuxizing result should always require no human intervention a=
s long as they can appear after the defective patch.

I have several situations for you to know my work flow.
1. ACPICA release
If this is not separated, then I should merge part of the defective pat=
ch into the new linuxized ACPICA commit that generates the merge confli=
ct.
This is a kind of so called "human intervention".
Then if a bug was found after the release testing work (may take severa=
l days) was done, I would have to linuxize the whole series again after=
 fixing the bug from the ACPICA upstream.
This results in a redo of the "human intervention". And this kind of "h=
uman intervention" may spread to all commits after the fixed one.
=46urthermore, the "human intervention" could happen again and again du=
ring the recursive release testing process.

There are similar cases:
2. Fast path ACPICA commits
We have something that can't be confirmed from ACPICA development envir=
onment, and they need to go Linux repo first.
Such kind of patch series also contain such a separated defective patch=
=2E
If this is not separated, then since the series need to be rebased agai=
n and again during the development process (because of bug fixing or Li=
nux upstream sync).
Then the "human intervention" need to be performed again and again.

3. The "process fixing commit"
If this problem is fixed, I need the Linux side correction to happen on=
ly when this commit is about to enter linux repo.
Otherwise, all commits between the merge point of this commit and the c=
urrent repo head need "human interventions".
Sometimes, these commits need to be linuxized and posted on the Bugzill=
a/community to have users to test them.
As the working kernel of the reporters or the developers are different,=
 the "human interventions" have to be performed again and again for the=
m.
And there will be many different versions of such kind of linuxized ACP=
ICA patch series.=20
It's not convenient for everyone.

So you can sense, the workload of the "human intervention" depends on t=
he following 2 facts:
1. How worse the "unsynced state" is in the current Linux repo, and thi=
s also depends on how big the linuxized "process fixing commit" will be=
=2E
2. The merge timing of the "process fixing commit" where the state shou=
ld be synced and the merge timing of other unsynced commits that could =
happen before this synced point.

I cannot control the merge timing of the "process fixing commit" and th=
e merge timing of other unsynced commits.
So I have to control the "unsynced state" otherwise my bandwidth will b=
e easily filled up by the "human intervention" due to the uncontrollabl=
e "merge timings".
You can easily imagine that my every work minutes will be filled up wit=
h the "human intervention" if I cannot control the "unsynced state".
This is a kind of job for a machine, while you are forcing me to be a m=
achine by simply saying: it's my business, not yours...
Is that worthy? Should I allocate more bandwidth to work on real issues=
 rather than doing the "human intervention" with such a heavy load?

The above is a justification for why I was thinking I had already obtai=
ned the agreement or the forgiveness from Linux upstream to generate su=
ch kind of defective patch to make my life easier.

Thanks and best regards
-Lv
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
