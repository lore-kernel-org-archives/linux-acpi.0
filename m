From: Eric Piel <Eric.Piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>
Subject: Re: [PATHC] Relaxed syntax for the processor PBLK length
Date: Mon, 31 Jan 2005 16:11:59 +0100
Message-ID: <41FE4ABF.9040100@tremplin-utc.net>
References: <41FD3E02.8010701@tremplin-utc.net> <20050131145836.GA1145@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050131145836.GA1145-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Bruno Ducrot a =C3=A9crit :
> On Sun, Jan 30, 2005 at 09:05:22PM +0100, Eric Piel wrote:
>=20
>>Hello,
>>
>>In the original DSDT of my laptop (Acer TravelMate 614) the processor=20
>>PBLK length is declared to be 5. The legal and only allowed value is 6.=
=20
>>This is an error in the DSDT and actually it is 6. Allowing Linux ACPI=20
>>to read also processor PBLK length of 5 works and permits the processor=
=20
>>to have the C-states correctly detected. In turn it allows the processo=
r=20
>>to get less hot (so this is eventually useful).
>>
>>I've noticed that some other Acer DSDT also have this length=20
>>mis-indicated. The attached patch adds some logic to the ACPI to allow =
a=20
>>processor PBLK length of 5 when the syntax is relaxed.
>>
>=20
>=20
> You should consider to disable C3 in this case IMHO.
Why? Actually this patch is especially designed to allow C3 state to be=20
used on my computer. This works for more than 6 months without any=20
appearent problem, is there anything I'm not aware of?

Eric


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
