From: Eric Piel <Eric.Piel-VkQ1JFuSMpfAbQlEx87xDw@public.gmane.org>
Subject: Re: [PATHC] Relaxed syntax for the processor PBLK length
Date: Mon, 31 Jan 2005 16:44:48 +0100
Message-ID: <41FE5270.8030605@tremplin-utc.net>
References: <41FD3E02.8010701@tremplin-utc.net> <20050131145836.GA1145@poupinou.org> <41FE4ABF.9040100@tremplin-utc.net> <20050131152931.GC1145@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050131152931.GC1145-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
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
Cc: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Bruno Ducrot a =C3=A9crit :
> On Mon, Jan 31, 2005 at 04:11:59PM +0100, Eric Piel wrote:
>=20
>>Why? Actually this patch is especially designed to allow C3 state to be=
=20
>>used on my computer. This works for more than 6 months without any=20
>>appearent problem, is there anything I'm not aware of?
>=20
>=20
> I thought some BIOS devellopers wanted to use a size for the
> pblk of 5 just to not allow C3 (which correspond to the sixth io
> register).
>=20
> I'm not alone to think this.
>=20
> Nate: FreeBSD allow only C2 in this case.  What do you think about this
> report?
> Do you have an example of some kind of malfunction when enabling C3?

Actually in the DSDT the C2 seems really deactivated (latency is set to=20
the maximum, something like 999 ms) while C3 has a declared latency that=20
seems realistic. Additionally, in the C3 state, the computer works=20
perfectly.

Is there anyway in Windows to check if it uses a particular C state?

Eric


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
