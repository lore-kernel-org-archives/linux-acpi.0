From: =?iso-8859-1?q?Jo=E3o_Cardoso?= <jcard-A1Gx7Te15Zc@public.gmane.org>
Subject: Re: ASUS M3N standby resume regression in 2.6.x -- works under 2.4.x
Date: Mon, 17 Jan 2005 01:45:57 +0000
Message-ID: <200501170145.58041.jcard@fe.up.pt>
References: <200501111652.28556.jcard@fe.up.pt> <200501141909.34406.jcard@fe.up.pt> <41E82E48.6070403@pca.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41E82E48.6070403-wlebWZzHoyE@public.gmane.org>
Content-Disposition: inline
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

On Friday 14 January 2005 20:40, Luca Capello wrote:
|  Hello,
|
|  on 01/14/2005 08:09 PM, Jo=C3=A3o Cardoso wrote:
|  > OK, I have compiled 2.6.11-rc1 without USB support.
|
|  <cut>
|
|  > ... e100_suspend+0x8b/0xe0
|  > ... e100_suspend...
|  > So, there is obviously a problem with the e100 network driver.
|
|  I think so, but have you tried with the eepro100 driver instead?

No, lets fix acpi first.

|  > S3 doesn't work either, but never worked, even in 2.4.xx
|
|  Have you searched on the mailing-list archive for my posts [1]? I had an
|  M3N (M3410C) for a while and I tried sleep modes with different kernels.
|  I don't remember exactly the results, but IIRC S3 worked quite well. And
|  AFAIK Georg Greve made other tests with some positive results.

Yes, I have followed your posts and results. S1 works fine with the 2.4.x=20
kernels. I have not tried S3. Thanks a lot for your efforts and results!

I have resisting to change to the 2.6.x kernels because of the S1 issue, (I=
=20
think that a laptop without a S1or S3 is almost useless), but sooner or lat=
ter=20
I have to change.

|  > What is the next step? A new laptop? WinXP? (sorry, but I'm not exactly
|  > happy)
|
|  No, I was very happy with this laptop, so I don't advice you to change i=
t.

My comments were because the laptop refused to start up after the loockup. =
I=20
was really *very*, *very* worried, as you can imagine. I only can advise=20
anyone that's trying acpi to imediately shutdown theirs laptop if it freeze=
s.

I believe that in the previous kernels, in my laptop at least, the=20
temperature/fan was managed by the bios -- a few seconds after a lookup the=
=20
fan started turning at maximum speed. That is not the case anymore.

|  Thx, bye,
|  Gismo / Luca

Thanks,
Joao


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
