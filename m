From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 1/5] trace, RAS: Add basic RAS trace event
Date: Wed, 16 Apr 2014 02:33:01 -0400
Message-ID: <20140416063301.GC11297@gchen.bj.intel.com>
References: <1395985981-20476-1-git-send-email-gong.chen@linux.intel.com>
 <1395985981-20476-2-git-send-email-gong.chen@linux.intel.com>
 <20140409194654.GR6529@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UFHRwCdBEJvubb2X"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:61300 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754708AbaDPG6O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Apr 2014 02:58:14 -0400
Content-Disposition: inline
In-Reply-To: <20140409194654.GR6529@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, m.chehab@samsung.com, rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com


--UFHRwCdBEJvubb2X
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2014 at 09:46:54PM +0200, Borislav Petkov wrote:
>=20
> menuconfig RAS
> 	bool "Reliability, Availability, Serviceability features"
> 	help
> 	  <A nice text about what this is going to contain, i.e. RAS stuff
>=20
How about this:

         Reliability, availability, and serviceability (RAS) is a computer
         hardware engineering term. Computers designed with higher levels
         of RAS have a multitude of features that protect data integrity
         and help them stay available for long periods of time without
         failure.

         Reliability can be defined as the probability that it will produce
         correct outputs up to some given time. Reliability is enhanced by
         features that help to avoid, detect and repair hardware faults.

         Availability is the probability a system is operational at a given
         time, i.e. the amount of time a device is actually operating as the
         percentage of total time it should be operating.

         Serviceability or maintainability is the simplicity and speed with
         which a system can be repaired or maintained; if the time to repair
         a failed system increases, then availability will decrease.

         Note that reliability and availability are distinct concepts:
         Reliability is a measure of the ability of a system to function
         correctly, including avoiding data corruption, whereas availability
         measures how often it is available for use, even though it may not
         be functioning correctly. For example, a server may run forever and
         so have ideal availability, but may be unreliable, with frequent
         data corruption.


--UFHRwCdBEJvubb2X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTTiQdAAoJEI01n1+kOSLHiWgQAJC7B7cZ3jIpVmdUsTEHmWPK
YhhqWRuVjfnD+34UHHabTpPefaO/MO0bMBlrpBWyJ/BCsmab1T2eE6hGPrbfNVrf
l2MyE67C8O7CJoV4AztdGsjR3NHwepBPdIzI1eQwSKRfCQm3Ujo6SFs37ApdlSlk
aASBo95ku1ucHSQgepzBd609gHK5kvvolQr0sMwQMCJYacQ02QgOdoTyJRK6lgEY
CRL42p5GKRcXL8461Ggxt6C06xkXSfbtngONQkb0BvSkPogFtsZZrNWWUg/xav3X
m9P0yl6awey1+deOlryHUhOIe1ElKqP7+mLDRYmvOGsHs11D/5UHCeqMdDKB63RE
9OM2+wkBWW7w3PvrW+qJWUqZSUkCRPVDzplRD/QbzHX6EQNot1PMXYPTpyqCviRZ
77hty6niYRJWDtJlfBlEHIwfVZZov/Dzzzd5GBzn9AGFsLfkdG5ID0Tsy5H2263j
HCiEEW9FbChRDM1v11zISTxQIBX8mxJIXNvfrM7KWB7MV83BRCfgVcdqb3ygi7kL
dzPDWsBDv5vPXFYpwMawX8F5aHdTWdc2cazhZoV+YV7mVQUFsA8WjqX3eZXbN8nt
/BGHFQ3mrCLRK2oGKQRpFbixieoeP4W1MvzyhAH6iDfFh5z00CdsBGvB9Dvrt8I7
Tlwaf0Zz72GK4U8bDT4Q
=hnon
-----END PGP SIGNATURE-----

--UFHRwCdBEJvubb2X--
